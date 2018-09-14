# AI 챗봇 만들기

## RNN

순환신경망. 기존 모델은 연속적인 데이터, 즉 이전의 정보가 나중의 정보에 영향을 미치는 데이터를 효과적으로 처리하지 못함. 이전에 들어온 정보를 저장 해 두었다가 다음에 들어올 정보를 판별하는데 사용하기 위해 고안 된 것이 RNN.

이전의 정보(Xk)를 저장해 다음의 정보(Xk+1)와 함께 Yk+1을 예측함.

### RNN의 한계

오래된 입력일 수록 정보가 점점 희미해져감. `나는 한국인입니다. ....(중략)... 나는 ___을 잘합니다.` 여기서 한국어라는 키워드를 예측하기 위해서 앞에서 입력된 한국인에 대한 정보를 보존하고 있어야 함. RNN(Back Propagation)의 경우 오래된 입력의 정보가 희미해짐.

- RNN-LSTM: RNN의 한계를 보완한 알고리즘. RNN + Cell State.
- RNN-LSTM with Attention Weight: 각 요소별로 가중치 값을 부여. 중요한 요소에 높은 가중치 부여해서 나중에 사용

### seq2seq 모델

#### - 인코더: Embedding

- One hot encoding으로 질문 입력: 단어간 관계를 표현하지 못한다.
- 단어의 유사도를 고려해서 벡터 공간에 배치하면 어떨까?
- 단어의 유사도를 어떻게 정의할 것인가? 비슷한 분포를 가진 단어들은 비슷한 의미를 가짐 --> 비슷한 분포도를 가진 단어들의 유사도가 큼.
- One hot encoding을 embedding vector로 바꿈

#### - Thought Vector

인코딩 된 입력값을 생각벡터로 표현한다. 이렇게 만들어진 생각벡터가 디코더의 입력으로 사용된다.

### Dropout

훈련용 데이터의 일부만 가지고 학습함. 과적합(Over fitting)을 방지하기 위해 사용하는 기법. 연산량이 줄어들어 학습시간도 줄어든다.

## 실습

```bash
Day3/3_RNN_chatbot/chatbot_code+ui
source activate ml2
python app.py
# training 중이면 seq2seq.py 마지막 부분 주석처리
```

## CNN

```bash
cd Day3/4_cnn_topic_classification/ui
source activate ml2
python app.py
```

### Regularization(=정규화)

모델이 더 단순한 Weight를 선택하도록 하는 역할. Loss에 정규화 Term 추가 = Weight에 제약조건  
과적합을 줄이기 위한 기법.

### epoch, batch

- epoch: 똑같은 데이터로 몇번을 학습할 것인지 결정. 값이 높아서 같은 데이터로 너무 많이 학습하면 과적합 발생 가능성.
- batch: 한 번에 몇개의 데이터를 가지고 학습할 것인지 결정.
