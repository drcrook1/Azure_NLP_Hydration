# Azure_NLP_Hydration
Shows how to hydrate Azure based NLP solutions programatically for the purposes of deploying baseline to customers and then layering customizations on top.

## How to Run Example
1.  Rename "sample.dev.env" to "dev.env"
2.  Populate dev.env with your variables for subscription etc.
3.  Run "build_deploy.sh".  This will deploy Luis, QnA Maker, and Bot framework into 2 resource groups.  It will then upgrade each one slightly differently and then deploy the 2 different versions to the two resource groups.
4.  You can then modify each QnA Maker, Bot Framework and/or Luis manually and then run "build_upgrade.sh" which will then upgrade the original 3 services with an additional capability and then layer the manual customizations you made on top of it.

## Disclaimer
This is an open sourced sample.  It makes no promises of any kind.  You accept all responsibility for usage.