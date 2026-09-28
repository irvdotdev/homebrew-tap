import hashlib,json,os,urllib.request,urllib.parse
from pathlib import Path

def get(url):
    headers={'User-Agent':'bohselecta-homebrew','Accept':'application/vnd.github+json'}
    if urllib.parse.urlparse(url).hostname=='api.github.com' and os.environ.get('GH_TOKEN'):
        headers['Authorization']='Bearer '+os.environ['GH_TOKEN']
    request=urllib.request.Request(url,headers=headers)
    return urllib.request.urlopen(request,timeout=60).read()

releases=json.loads(get('https://api.github.com/repos/irvdotdev/bohselecta/releases?per_page=30'))
for release in releases:
    assets={asset['name']:asset['browser_download_url'] for asset in release['assets']}
    if release['draft'] or not {'bohselecta.rb','SHA256SUMS'}<=assets.keys():
        continue
    formula=get(assets['bohselecta.rb'])
    sums=dict((line.split('  ',1)[1],line.split('  ',1)[0]) for line in get(assets['SHA256SUMS']).decode().splitlines() if '  ' in line)
    if hashlib.sha256(formula).hexdigest()!=sums.get('bohselecta.rb'):
        raise RuntimeError('Released formula checksum did not match')
    Path('Formula/bohselecta.rb').write_bytes(formula)
    print('Verified formula from '+release['tag_name'])
    break
else:
    print('No release with a Homebrew formula yet; keeping current formula.')
