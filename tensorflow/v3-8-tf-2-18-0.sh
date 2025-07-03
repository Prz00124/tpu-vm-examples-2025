# Create tpu vm with name test123 (the TPU_NAME).
gcloud compute tpus tpu-vm create test123 --zone=us-central1-a --version=tpu-vm-tpu-vm-tf-2.18.0-se --accelerator-type=v3-8 --spot

# Setting TPU_NAME = "local" and upload the test script
gcloud compute tpus tpu-vm scp ./test_tpu.py test123: --zone=us-central1-a

# Reinstall tensorflow-tpu and libtpu.
gcloud compute tpus tpu-vm ssh test123 --zone=us-central1-a --worker=all --command="sudo apt-get update && pip install --upgrade pip && pip install tensorflow-tpu==2.18.0 -f https://storage.googleapis.com/libtpu-tf-releases/index.html --force-reinstall"

# Execute the test script.
gcloud compute tpus tpu-vm ssh test123 --zone=us-central1-a --worker=0 --command="python test_tpu.py"

# You should see 8 tensor printed.