# Create tpu vm with name test123 (the TPU_NAME).
gcloud compute tpus tpu-vm create test123 --zone=us-central1-a --version=tpu-vm-tf-2.16.1-se --accelerator-type=v3-8 --spot

# Setting TPU_NAME = "local" and upload the test script
gcloud compute tpus tpu-vm scp ./test_tpu.py test123: --zone=us-central1-a

# Execute the test script.
gcloud compute tpus tpu-vm ssh test123 --zone=us-central1-a --worker=0 --command="python test_tpu.py"

# You should see 4 tensor printed.