mkdir -p dist
rm -f dist/wsl-onboarding.zip
zip -r dist/wsl-onboarding bin/ lib/ share/ run-setup.ps1 
md5sum dist/wsl-onboarding.zip > dist/wsl-onboarding.md5
