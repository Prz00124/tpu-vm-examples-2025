#TPU_NAME = "local" # single host
#TPU_NAME = "test123" # multi host, using in pod (slice).

import tensorflow as tf

print("Tensorflow version " + tf.__version__)

cluster_resolver = tf.distribute.cluster_resolver.TPUClusterResolver(TPU_NAME)
tf.config.experimental_connect_to_cluster(cluster_resolver)
tf.tpu.experimental.initialize_tpu_system(cluster_resolver)
strategy = tf.distribute.experimental.TPUStrategy(cluster_resolver)

@tf.function
def add_fn(x,y):
  z = x + y
  return z

x = tf.constant(1.)
y = tf.constant(1.)
z = strategy.run(add_fn, args=(x, y))
print(z)