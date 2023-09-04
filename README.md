# First steps with infrastructure as code on AWS: Deploying an S3 Bucket using Terraform

This blog will take you through the process of deploying an S3 bucket using Terraform. 
Amazon S3 (Simple Storage Service) is an essential AWS service used as part of many web
applications and services. You can imagine it to be comparable to a folder which you use on 
your local machine to store data. When combined with Terraform, a popular infrastructure as 
code tool, you can automate and version control your infrastructure deployments.  

## Requirements
Before you start make sure you have:
1. An AWS account: You can sign up for free [here](https://portal.aws.amazon.com/billing/signup#/start/email)
2. The AWS CLI installed: You can find a detailed instruction [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Note
You can test a lot of the basic AWS services for free. Creating an S3 bucket will not incur any 
charges by default. You're only charged for the storage and operations you use. Executing this 
stack did not cost me anything. 

## Setting up for Terraform Deployment
1. Creating a user for local AWS CLI use:
   - Log into the AWS console using your AWS account [here](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fs3.console.aws.amazon.com%2Fs3%2Fbuckets%2Fbucket-predict-stocks%3Fprefix%3Dmodels%252F2%252F48791f4d01b346b79af2b619612fb8c9%252Fartifacts%252Fmodel%252F%26region%3Deu-west-1%26showversions%3Dfalse%26state%3DhashArgs%2523%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fs3&forceMobileApp=0&code_challenge=ew8BtYoH1q8W2m9sIyjI2zF7Ma9HC3_t0tkpRwtFB-A&code_challenge_method=SHA-256)
   - Navigate to the IAM (Identity and Access Management) service in AWS. 
![AWS_IAM.png](images%2FAWS_IAM.png)
   - Add a new user which we can use for programmatic access.
![AWS_existing_user.png](images%2FAWS_existing_user.png)
   - First you need to choose a name.
![AWS_user_name.png](images%2FAWS_user_name.png)
   - Then you need to attach a policy to the user. Policies define what AWS users or AWS roles are 
   allowed to do in the cloud. For this basic example we select a AWS managed policy `AmazonS3FullAccess`.
   With this policy our user has full control over S3. Remember, in a real-world scenario, you would 
   limit permissions to follow the principle of least privilege, but for this introductory example 
   full access is fine.
![AWS_attach_policy.png](images%2FAWS_attach_policy.png)
   - After attaching the policy you can review what you did so far and create the user.
![AWS_create_user.png](images%2FAWS_create_user.png)
   - Now you should see your newly created user in the list of users.
![AWS_user_list.png](images%2FAWS_user_list.png)
   - Select the newly created user in order to create an access key by clicking on `Creat access key`.
![AWS_selected_user.png](images%2FAWS_selected_user.png)
   - You will have to choose your use case and get a recommendation by AWS to evaluate if a access key is
   secure for what you are trying to do. For this simple example it should be fine to continue.
![access_key_best_practices_alternatives.png](images%2Faccess_key_best_practices_alternatives.png)
   - Subsequently, you can add a tag to label your key.
![key_tag.png](images%2Fkey_tag.png)
   - Finally, you can retrieve your access key.
![retrieve_access_key.png](images%2Fretrieve_access_key.png)

## Note
Do not share your access key and be very careful to not display it to github. Someone else could use it
and create costs in your AWS account.

2. Configure AWS CLI on your local machine:
   - To connect to AWS from my local machine, I found it to be the easiest way to configure a profile. 
   The profile is connected to the user you just created. This option also enables you to create several 
   users and profiles with different permissions. Just type `aws configure --profile <profile_name>` into
   your terminal and enter the access key ID and secret of your user. You must also enter a default region.
   It is advisable to choose a AWS region that is not far from the location of the users of your services. 
   For this example it does not matter.
![terminal_configure_AWS_profile.png](images%2Fterminal_configure_AWS_profile.png)
   - Next, we want to verify if everything worked correctly. Let's see if we can find your profile in the
   list of available AWS profiles by typing `aws configure list-profiles` and by listing your AWS S3 buckets
   by typing `aws s3api list-buckets --profile <profile_name>` into your terminal.
![terminal_list_buckets.png](images%2Fterminal_list_buckets.png)

3. Create a S3 bucket to keep track of your Terraform state:
   - Now that we have an AWS profile, we can prepare for using Terraform. First, we need an S3 bucket
   that Terraform can use to keep track of the state of the infrastructure we let Terraform create for us.
   This is a manual process, because the name of the S3 bucket is an input to Terraform. You can either 
   create an S3 bucket using the AWS console or you make use of your new profile.
   - The command to create the S3 bucket is 
   `aws s3api create-bucket --bucket <bucket_name> --region <aws_region> --create-bucket-configuration LocationConstraint=<aws_region> --profile <profile_name>`
   - The create-bucket-configuration argument is required for regions different from `us-east-1`.
![create_bucket_terminal.png](images%2Fcreate_bucket_terminal.png)
   - For this example, I called my manually created S3 bucket `terraform-states-cloud`.
   
## Note
You can easily remove an S3 bucket from your terminal using this command: 
`aws s3api delete-bucket --bucket <bucket_name> --profile <profile_name>`. 
It can only be deleted if it is empty. You can delete all it's content by using: 
`aws s3 rm s3://<bucket_name> --recursive --profile <profile_name>
`

4. Prepare Terraform:
- best to have a separate folder
- best practice to have a variables.tf file to define variables like that might change which will be pasted 
to the main.tf file which defines the infrastructure
- explain the purpose of the main.tf file and the content

5. Execute Terraform:
`cd i
nfrastructure`

`terraform init`

`terraform plan`

`terraform apply`

`terraform destroy`
