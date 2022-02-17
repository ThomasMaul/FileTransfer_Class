<!-- Type your summary here -->
## Description

Uses https://github.com/dropbox/dbxcli

We use a command line interface tool from Dropbox.
Dropbox wrote it in language "Go", which allows to compile a single binary which could be embedded in your application and deployed with it (Apache License).

If Dropbox changes the API, just download their latest release and replace the binary.

For Mac:
The downloaded binary is not signed, so execution on Mac is limited (you need to launch with Control key pressed). To use and deploy we advise to sign it, and then sign/notarize the embedding 4D application.

Setup on customer computer / Both platforms:
To authorize the binary, you need to execute it once through terminal/console and enter:
{path}dbxcli ls

It will ask for access:
1. Go to https://www.dropbox.com/1/oauth2/authorize?client_id=07o23gulcj8qi69&response_type=code&state=state
2. Click "Allow" (you might have to log in first).
3. Copy the authorization code.
Enter the authorization code here:
xxxx

This needs to be done manually once.

 codesign --force --sign "Developer ID Application: 4D Deutschland GmbH" /Users/thomas/Desktop/dbxcli 