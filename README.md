# WebTools (formerly WebUnit)

Note for existing users of this package: As of March 2, 2018 I am renaming this package from WebUnit to WebTools to avoid naming
conflicts with future releases of the Wolfram Language (which will include parts of the WebUnit functionality).

WebTools is a package written in the Wolfram Language which automates interaction with a web browser using the JSON wire protocol.

Supported functionality includes:

* Starting and stopping a web browser
* Opening web pages and switching to web pages in different browser tabs
* Typing in input fields and clicking links
* Reading web page content and taking screen shots
* Executing javascript in the current browser session and returning javascript function results

To install this package:

* Navigate to the 'Releases' area of this repository: https://github.com/arnoudbuzing/webtools/releases
* Download the most recent WebTools-x.y.z.paclet file from this page
* Start the Wolfram Language and evaluate the following command (replacing x.y.z with the actual version digits):

`PacletInstall["<path to downloads>/WebTools-x.y.z.paclet"]`

Then, open the `usage.nb` notebook to see basic usage for the supported functions.
