# TPU2025_Examples
It's a repository of __tpu vm__ settings on July 2025.

Due to the examples on official tutorial is confusing, I tried several configures of TPU vm. Here is it.

# TPU 
- spot is cheeeeeap.
- Depends on the number of hosts. you can check this information at [TPU version](https://cloud.google.com/tpu/docs/v5e). Whenever the number of hosts > 1, you have to pick a runtime version which decorated with __-pod__, and tensorflow can not resolve tpu derectly (in local).

# Tensorflow
- For tensorflow>=2.16.
- Not support tpu __v6e__ til __now (2025.06)__, though there are some runtime versions for it. You will find that tensorflow can't initialize or recognize tpu v6e properly. If there is any progress, please remind me.
- For tpu __v5litepod (v5e)__ and __v5p__, the PJRT runtime is required. Choose a runtime version decorated with __-pjrt__. Fortunately we don't need to change any code.
- For tpu __v3__, choose a runtime version decorated with __-se__ .
- In tensorflow __2.17__ and __2.18__, it crushes into segfault error when you import tensorflow in python. It's a bug from libtpu and can be fixed by reinstall tensorflow-tpu and libtpu by:

  > pip install tensorflow-tpu -f https://storage.googleapis.com/libtpu-tf-releases/index.html --force-reinstall

  This works for __Kaggle notebook__, too. If you met an error that the train/valid loss turn into nan at around __39th__ batch without any reason on tpu v3-8, please reinstall tensorflow-tpu with libtpu in the begining of notebook.
- To access the tpu in tensorflow,
  > cluster_resolver = tf.distribute.cluster_resolver.TPUClusterResolver(TPU_NAME)    
  > tf.config.experimental_connect_to_cluster(cluster_resolver)    
  > tf.tpu.experimental.initialize_tpu_system(cluster_resolver)    
  > strategy = tf.distribute.experimental.TPUStrategy(cluster_resolver)    

  are necessary. You have to pass __TPU_NAME__ to __TPUClusterResolver__ and pass __cluster_resolver__ to __TPUStrategy__ in tensorflow>=2.16 . The information provided by LLM is not reliable.

- > tf.distribute.get_strategy()    

  won't catch tpu.

# Pytorch
TBA

# Note
- I am still figuring out the tpu setting in skypilot.
- So as Jax.