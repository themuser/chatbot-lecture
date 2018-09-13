# 개발

- 챗봇 개요/실습
- 한글 전처리
- 키워드 기반 챗봇 제작
- 딥러닝 개요

## 시작하기 전에

모듈간 충돌을 방지하기 위해 아나콘다의 모듈 컨테이너를 활용한다. 용도에 따라서 모듈을 여러개로 나누고 필요에 따라 해당 모듈을 activate 시키는 방식임.

```bash
source activate ml
jupyter notebook
```

juypter notebook 실행을 통해서 나오는 웹페이지에서 파이썬 코드를 line-by-line으로 실행 가능(shift + enter).

## 오탈자 교정 실습

Levenshtein disance를 이용한 띄어쓰기 실습.

### 띄어쓰기 교정

한국어는 띄어쓰기가 잘 되어있지 않아도 가독성에 큰 영향이 없음. 특히 온라인에서 작성되는 텍스트에는 띄어쓰기 오류 존재.  
띄어쓰기의 경우 Tokenization / tagging에 영향을 줄 수 있기 때문에 띄어쓰고 오류를 교정하면 이후 자연어 처리 성능이 향상될 수 있음.

### KoNLPy

한국어 형태소 분석을 위한 파이썬 패키지. 5개 형태소 분석기가 내장.

- 형태소 분석: 형태소를 비롯하여 어근, 접두/접미사, 품사 등 다양한 언어적 속성의 구조를 분석
- 품사 태깅: 형태소의 뜻과 문맥을 고려하여 품사를 지정하는 일

### KoNLPy Tutorial

```bash
source activate ml
jupyter notebook
```

Day1> 2_nlp > 2) konlpy_tutlrial > 1. konlpy.ipynb 각 문장을 형태소 분석하는 샘플

### soynlp Tutorial

Day1> 2_nlp > 2) konlpy_tutlrial > 2. soynlp.ipynb 각 문장을 형태소 분석하는 샘플

soynlp와 KoNLPy를 결합해서 사용하면 형태소 분석 정확도를 더 높일 수 있다.

## 카카오 API를 활용한 챗봇 제작

영화 좌석정보를 알려주는 카카오 플러스 친구 챗봇 제작해보기

```bash
cd ./Day1/1_kakao_build
# aws에서 사용을 위해 elastic beanstalk 설치되어있어야 함
# http://blog.jeonghwan.net/eb-cli-%ED%88%B4-%EC%82%AC%EC%9A%A9%EB%B2%95-%EC%A0%95%EB%A6%AC/
eb status
eb deploy
```

- [카카오 플러스친구](https://center-pf.kakao.com) 접속 후 회원가입, 플러스친구 생성
- 스마트채팅 > API형 설정
- 앱 URL에 `eb status` 명령 결과로 나온 CNAME 붙여넣기
- API URL 확인하고 [API형 저장하기]

### application.py 코드 분석

- 서버와 API를 받기 위하여 Flask 모듈 사용.  
- 아래 두개는 반드시 필요함

```python
def Keyboard():
def Message():
```

- opening: 챗봇 시작할 때 나올 메시지
- 카카오에서 사용자에 대한 고유번호를 hash 값으로 전달함. 사용자별로 서비스를 제공하기 위해서는 이 hash 값을 서비스용 DB에 저장할 필요.

```python
# flask의 request 함수로 json 형태의 데이터를 읽어옵니다.
dataReceive = request.get_json()

# 유저의 입력
user_input = dataReceive['content']
# 유저의 아이디 값
sessID = dataReceive['user_key']
```

## 한글 데이터 처리 & DNLP

- 토픽 모델링
- [워드 임베딩](http://w.elnn.kr/search)
- NER
- 감성분석

### 워드 임베딩

- 컴퓨터에서 단어를 처리하기 위해 컴퓨터가 이해할 수 있는 방식으로 변환
- Word2Vec: Day1/2_nlp/4) Korean_word2vec_tutorial
- Gensim
- Glove 등

### NER

- 텍스트로부터 인명, 지명, 기관명 등과 같은 개채명을 인식하여 해당 개체명 태그를 달아주는 작업

```bash
cd .Day1/2_nlp/5\)\ Korean_ner_tutorial/applications/named_entity_recognition
python tf_train.py
```

### 감성분석

문장에 속해 있는 감정의 극성(polarity)을 구분하는 문제

```bash
cd .Day1/2_nlp/6\)\ sentiment_analysis_tutorial/
source activate ml2
python doc2vec_run.py
```

## Trouble Shooting

python 프로그램 실행시 OutOfMemory 오류 발생시 아래 명령어 실행 해서 메모리를 많이 차지하고 있는 python 프로세스를 강제 종료

```bash
nvidia-smi
```

## 아이나비 고객센터 챗봇

카톡 API의 한계는 계층구조 구성이 불가능하고 1질문에 1답장 밖에 안됨. 카테고리별로 유저가 질문을 타고 들어갈 수 있는 tree 모델 필요.

```bash
cd ./Day1/3_advChatbot/2-aft/ui
source activate ml
python app.py
```

## 딥러닝

챗봇에 인공지능이 왜 필요한가?

- [Stitch Fix](https://www.stitchfix.com/): 딥러닝을 통한 추천결과와 스타일리스트의 추천을 적절히 결합하여 원하는 옷을 추천
- 넷플릭스: 일반 사용자들의 별점 예측 알고리즘 대회 개최
- [kaggle](https://www.kaggle.com/): 딥러닝 기반 Competition

Train Set, Valid Set은 반드시 따로 존재해야 한다.
