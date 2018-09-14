# TensorFlow

- 구글에서 오프소스로 공개한 기계학습 라이브러리, 기계학습 과정을 일반인들도 접근하기 쉽게 만듬.
- 그래프 자료구조를 사용하여 연산
- 그래프의 노드는 오퍼레이션(op)라고 부름

```text
1. 그래프 객체를 만든다.
2. 노드를 채워넣는다.
3. 오퍼레이션 실행한다.
4. 오퍼레이션에 따라 그래프가 변화한다.
```

- 텐서(Tensor): 일종의 다차원 배열. 내부적으로 그래프의 모든 데이터는 텐서를 통해 표현되며 오퍼레이션간에는 텐서만이 전달 됨.
- 오퍼레이션(Operation, OP): 계산을 수행하고 결과를 하나 이상의 텐서로 변환할 수 있음
- 세션(Session): 오퍼레이션을 수행하기 위한 그래프들을 담은 객체
- 변수(Variable): 그래프 실행시 메모리상에서 텐서를 저장하는 버퍼 역할(var)
- 상수(Constant): 메모리상에서 변하지 않는 값의 텐서를 저장하는 버퍼 역할(let, const)
- 플레이스 홀더(Placeholder): 사용자의 데이터를 입력받기 위해 비워둔 변수

## 실습1. Fully Connected

```bash
cd Day3/1_fully_connected
source activate ml2
```

초기화

```python
import tensorflow as tf
# one_hot = True : y값을 one_hot_encoding으로 읽음
# 0 = [1, 0, 0, 0, ...], 1 = [0, 1, 0, 0, 0, ...]
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)

X = tf.placeholder(tf.float32, [None, 784]) # 28 x 28 = 784(숫자 이미지 하나를 가로, 세로 28분할)
Y = tf.placeholder(tf.float32, [None, 10])  # 0 ~ 9 숫자를 담을 공간
keep_prob = tf.placeholder(tf.float32)
```

함수 정의

```python
# 레이어 연산을 한 번 수행함
def nn_layer(name, input_data, output_size):
  W = tf.get_variable(name=name + "_W",
                      shape=[input_data.get_shape().as_list()[1], output_size],
                      initializer=tf.contrib.layers.xavier_initializer())
  B = tf.get_variable(name=name + "_B",
                      shape=[output_size],
                      initializer=tf.contrib.layers.xavier_initializer())
  return tf.matmul(input_data, W) + B
```

Hidden Layer 연산

```python
# tf.get_variable()은 두 번 실행하면 안됨.
with tf.name_scope("Layer2"):
  # 28 * 28 -> 14 * 14
  L2 = tf.nn.relu(nn_layer("L2", X, 14 * 14))
  L2 = tf.nn.dropout(L2, keep_prob=keep_prob)
with tf.name_scope("Layer3"):
  # 14 * 14 -> 14 * 14
  L3 = tf.nn.relu(nn_layer("L3", L2, 14 * 14))
  L3 = tf.nn.dropout(L3, keep_prob=keep_prob)
with tf.name_scope("Layer4"):
  # 14 * 14 -> 10 로 변환(2차원 -> 1차원)
  H = nn_layer("L4", L3, 10)
```

코스트 산정. 예측값 = Answer 일수록 cost가 작아지기 때문에 cost가 작아지도록 모델을 학습시켜야 한다.

```python
# hypothesis = tf.div(tf.exp(L3), tf.reduce_sum(tf.exp(L3)))
# cost = tf.reduce_mean(-tf.reduce_sum(Y * tf.log(hypothesis), axis=1))
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=H, labels=Y))
optimizer = tf.train.AdamOptimizer(learning_rate=0.01).minimize(cost)

is_correct = tf.equal(tf.argmax(H, 1), tf.argmax(Y, 1))
accuracy = tf.reduce_mean(tf.cast(is_correct, tf.float32))
```

학습 실행

```python
training_epochs = 15
batch_size = 100

with tf.Session() as sess:
  # Initialize TensorFlow variables
  sess.run(tf.global_variables_initializer())

  # Training cycle
  for epoch in range(training_epochs):
    avg_cost = 0
    total_batch = int(mnist.train.num_examples / batch_size)

    for i in range(total_batch):
      batch_xs, batch_ys = mnist.train.next_batch(batch_size)
      c, _ = sess.run([cost, optimizer], feed_dict={ X: batch_xs, Y: batch_ys, keep_prob: 0.7})
      avg_cost += c / total_batch

    print('Epoch:', '%04d' % (epoch + 1), 'cost =', '{:.9f}'.format(avg_cost), c)
  print('Accuracy:', sess.run(accuracy, feed_dict={ X: mnist.test.images, Y: mnist.test.labels, keep_prob: 1}))
```

실행결과: 정확도 약 96%  
cost 값은 train data cost, test data cost

```text
Epoch: 0001 cost = 0.391096732 0.2531832
Epoch: 0002 cost = 0.285878950 0.27162433
Epoch: 0003 cost = 0.278950680 0.40959346
Epoch: 0004 cost = 0.261430838 0.16377613
Epoch: 0005 cost = 0.256246079 0.22227041
Epoch: 0006 cost = 0.242022881 0.14403278
Epoch: 0007 cost = 0.244363701 0.17575882
Epoch: 0008 cost = 0.239582121 0.34981686
Epoch: 0009 cost = 0.227316516 0.13681158
Epoch: 0010 cost = 0.229217159 0.087932914
Epoch: 0011 cost = 0.223926081 0.24385801
Epoch: 0012 cost = 0.220405606 0.24583232
Epoch: 0013 cost = 0.224325338 0.17572442
Epoch: 0014 cost = 0.220725792 0.19651249
Epoch: 0015 cost = 0.211872156 0.27220243
Accuracy: 0.9615
```