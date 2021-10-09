# rsync deployments

This GitHub Action deploys *everything* in a configureable folder to a folder on a server via rsync over ssh. 

This action would usually follow a build/test action which leaves deployable code in the folder of your choosing.

# Required SECRETs

This action needs a `DEPLOY_KEY` or `DEPLOY_PASS` secret variable.