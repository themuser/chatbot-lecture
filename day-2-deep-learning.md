# 딥 러닝

2010년대에 접어들면서 기계학습 분야가 크게 발전. 이에 따라 자연어처리 기술 역시 비약적으로 발전함.

- 트리탐색(몬테카를로 검색)
- 마르코프 의사결정

## 인공지능 팩맨 만들기

```bash
cd Day2/1_ML(Pacman)
cat commands.txt
python pacman.py -p ApproximateQAgent -a extractor=CustomExtractor -x 50 -n 60 -l mediumClassic --frameTime 0.0005
```

## MNIST

딥러닝 입무에서 많이 사용. 활성화 함수에 의해 출력이 결정된다.(Sigmoid, RELU 등))

## CNN, RNN

- RNN: NLP 등에서 많이 사용
- CNN: 이미지/영상 처리에서 많이 사용

## Tensorflow

- Tensor: 다차원 배열. 그래프의 모든 데이터는 텐서를 통해 포함되며, 그래프 내의 오퍼레이션간에는 텐서만이 전달됨
- Operation: 그래프 상의 노드 오퍼레이션은 하나 이상의 텐서를 받을 수 있음.
- Session: 그래프에서 오퍼레이션을 실행하기 위한 메서드들을 담은 객체
- Variable: 변수. 메모리 상에서 텐서를 저장하는 버퍼역할
- Constant: 변하지 않는 값의 테서를 저장하는 버퍼역할

```bash
cd Day2/2_tensorfow
source activate ml2
```

텐서플로우 버전별로 operation API 차이가 많이 나는 경우가 있음. 이럴 때 requirements.txt를 활용해서 node.js > npm에서의 package.json 파일의 용도처럼 사용할 수 있음.

Session 으로 run 하기전까지는 Tensor 값이 전달되고 있는 상태임.

```python
node1 = tf.constant( 3.0, dtype=tf.float32) 
node2 = tf.constant( 4.0 )
node3 = tf.constant(4)
print(node1, node2) //Tensor("Const_5:0", shape=(), dtype=float32) Tensor("Const_6:0", shape=(), dtype=float32)
print(node3)    // Tensor("Const_7:0", shape=(), dtype=int32)

sess = tf.Session()
print(sess.run(node1))  // 3.0
print(sess.run(node2))  // 4.0
print(sess.run(node3))  // 4
```

Jupytor Notebook 입력 방식은 vi editor와 비슷하다. Command/Edit mode 두 가지로 나뉘고 Command mode에서 다양한 동작을 수행할 수 있다.