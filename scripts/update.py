import hashlib,json,urllib.request
from pathlib import Path

def get(url):
    request=urllib.request.Request(url,headers={'User-Agent':'bohselecta-homebrew','Accept':'application/vnd.github+json'})
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
