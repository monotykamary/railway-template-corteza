#!/usr/bin/env python3
import os,re,requests,urllib.parse
base=os.environ['BASE_URL'].rstrip('/');email=os.environ['ADMIN_EMAIL'];password=os.environ['ADMIN_PASSWORD']

def login(candidate):
    session=requests.Session();page=session.get(base+'/auth/login',timeout=30)
    assert page.status_code==200 and 'Corteza' in page.text
    token=re.search(r'name="same-site-authenticity-token" value="([^"]+)"',page.text).group(1)
    response=session.post(base+'/auth/login',data={'same-site-authenticity-token':token,'email':email,'password':candidate},allow_redirects=True,timeout=30)
    return session,response

health=requests.get(base+'/healthcheck',timeout=30);assert health.status_code==200 and 'pass' in health.text.lower()
version=requests.get(base+'/version',timeout=30);assert version.status_code==200 and '2024.9.9' in version.text
_,failed=login('not-the-password');assert urllib.parse.urlparse(failed.url).path=='/auth/login'
_,success=login(password);assert success.status_code==200 and urllib.parse.urlparse(success.url).path=='/auth' and 'Corteza' in success.text
for app in ('admin','compose','workflow'):
    page=requests.get(base+'/'+app+'/',timeout=30)
    assert page.status_code==200 and 'Corteza' in page.text,(app,page.status_code)
print('Corteza smoke checks passed')
