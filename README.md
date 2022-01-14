[![Build Status](https://travis-ci.com/usdot-jpo-sdc/sdc-dot-webportal.svg?branch=develop)](https://travis-ci.com/usdot-jpo-sdc/sdc-dot-webportal)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=usdot-jpo-sdc_sdc-dot-webportal&metric=alert_status)](https://sonarcloud.io/dashboard?id=usdot-jpo-sdc_sdc-dot-webportal)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=usdot-jpo-sdc_sdc-dot-webportal&metric=coverage)](https://sonarcloud.io/dashboard?id=usdot-jpo-sdc_sdc-dot-webportal)

# cleanup-worker
Utilities to identify and delete unused AWS resources within the US DOT Secure Data Commons (SDC) ecosystem.


## Table of Contents

[I. Release Notes](#release-notes)

[II. Usage Example](#usage-example)

[III. Configuration](#configuration)

[IV. Installation](#installation)

[V. Design and Architecture](#design-architecture)

[VI. Unit Tests](#unit-tests)

[VII.  File Manifest](#file-manifest)

[VIII.  Development Setup](#development-setup)

[IX.  Release History](#release-history)

[X. Contact Information](#contact-information)

[XI. Contributing](#contributing)

[XII. Known Bugs](#known-bugs)

[XIII. Credits and Acknowledgment](#credits-and-acknowledgement)

[XIV.  CODE.GOV Registration Info](#code-gov-registration-info)

[XV.  Code Quality Monitor](#code-quality-monitor)

---

<!---                           -->
<!---     Release Notes         -->
<!---                           -->

<a name="release-notes"/>

## I. Release Notes

**January 7, 2022. SDC cleanup-worker Release 1.0**
### What's New in Release 1.0
* AWS infrastructure to periodically detect and delete unused EBS volumes:
  * Lambda function implementation to support removal of unused volumes 
  * Terraform scripts to provision EventBridge Rule, lambda function, and IAM roles and policies to support the functionality


<!---                           -->
<!---     Usage Example         -->
<!---                           -->

<a name="usage-example"/>

## II. Usage Example


<!---                           -->
<!---     Configuration         -->
<!---                           -->

<a name="configuration"/>

## III. Configuration


<!---                           -->
<!---     Installation          -->
<!---                           -->

<a name="installation"/>

## IV. Installation

### Unused EBS volume cleanup installation

#### Deployment Plan
* Clone the cleanup-worker repository into a Linux environment (e.g., SDC build machine)
* Change to the cleanup-worker folder
* Change to the unused_volumes/deploy/terraform/ folder
  * cd unused_volumes/deploy/terraform/
* Execute the following commands to deploy the infrastructure:
  * terraform init
  * terraform apply -var-file=config/dev.tfvars


#### Test Plan
* Log on into the AWS Console for the SDC system account, navigate to the EC2 management area
* Navigate to volumes, create a stand-alone volume of 1 Gb and leave it unattached to any instance
* Wait for the EventBridge rulle to run as scheduled and verify that the volume is deleted.
  * Also, examine CloudWatch logs for the dev-cleanup-worker lambda function and verify that there are entries for deleted volume
```
START RequestId: bb4f6eb0-abc9-4eb9-aa6c-756a1ba19f4f Version: $LATEST
[INFO]	2022-01-06T14:24:42.544Z	bb4f6eb0-abc9-4eb9-aa6c-756a1ba19f4f	cleanup-worker lambda started.
[INFO]	2022-01-06T14:24:45.345Z	bb4f6eb0-abc9-4eb9-aa6c-756a1ba19f4f	Deleting volume vol-0814f00b7c83eff90
END RequestId: bb4f6eb0-abc9-4eb9-aa6c-756a1ba19f4f
```

#### Rollback Plan
* From the unused_volumes/deploy/terraform/ folder, execute the following command:
  * terraform destroy -var-file=config/dev.tfvars


<!---                                 -->
<!---     Design and Architecture     -->
<!---                                 -->

<a name="design-architecture"/>

## V. Design and Architecture


<!---                           -->
<!---     Unit Tests          -->
<!---                           -->

<a name="unit-tests"/>

## VI. Unit Tests





<!---                           -->
<!---     File Manifest         -->
<!---                           -->

<a name="file-manifest"/>

## VII. File Manifest


<!---                           -->
<!---     Development Setup     -->
<!---                           -->

<a name="development-setup"/>

## VIII. Development Setup



### Prerequisites


<!---                           -->
<!---     Release History       -->
<!---                           -->

<a name="release-history"/>

## IX. Release History

January 7, 2022. SDC cleanup-worker Release 1.0


<!---                             -->
<!---     Contact Information     -->
<!---                             -->

<a name="contact-information"/>

## X. Contact Information

For any queries you can reach to sdc-support@dot.gov


<!---                           -->
<!---     Contributing          -->
<!---                           -->

<a name="contributing"/>

## XI. Contributing


<!---                           -->
<!---     Known Bugs            -->
<!---                           -->

<a name="known-bugs"/>

## XII. Known Bugs




<!---                                    -->
<!---     Credits and Acknowledgment     -->
<!---                                    -->

<a name="credits-and-acknowledgement"/>

## XIII. Credits and Acknowledgment
Thank you to the Department of Transportation for funding to develop this project.


<!---                                    -->
<!---     CODE.GOV Registration Info     -->
<!---                                    -->

<a name="code-gov-registration-info">

## XIV. CODE.GOV Registration Info
Agency:  DOT

Short Description: The Secure Data Commons is an online data warehousing and analysis platform for transportation researchers.

Status: Production

Tags: transportation, connected vehicles, intelligent transportation systems

Labor Hours:

Contact Name: sdc-support@dot.gov

<!-- Contact Phone: -->

<a name="code-quality-monitor">

## XV. Code Quality Monitor


---
[Back to top](#toc)
