# 챗봇 개요

## 챗봇 샘플

- [IBM Watson 데모](https://watson-assistant-demo.ng.bluemix.net)
- [메리츠화재](https://www.merizfire.com/health-and-kids/accident/teeth-good.do#!/)

## 챗봇이 쓰이는 주요 이유

- 비즈니스 환경 변화
  - 비즈니스 환경이 웹, 앱에서 메신저로 이동
  - 스마트폰 보급으로 웹 환경에 대한 사용자 경험 저하, 각 기업은 **네이티브 앱**을 통해 경쟁력을 확보하려고 함
  - 많은 기업들이 `웹 ---> 앱`으로 이동했을 때 처럼 `앱 ---> 메신저`로 플랫폼을 이동 중
  - 대화를 주고받는 메시징 환경에서 가장 적절한 형태가 바로 챗봇
- 자연어 처리기술 발전: 딥러닝으로 인해 자연어 처리에 대한 기술이 폭발적으로 발전함
- 그 외
  - 24/365 대기 가능
  - 1:1로 상호작용하면서 사용자의 몰입도 높아짐. 일반적인 앱에 비해 월등한 도달률, 전환율
  - 마케팅 노력 절감: 기존 앱에 추가로 붙이기만 하면 됨

## 챗봇 방식

### Rule Based

도메인이 한정적일수록, 높은 신뢰도가 필요할수록 좋음  
신뢰도는 높지만 범용성을 높이기가 어려움

### AI Model

도메인이 범용적일수록, 동작이 복잡할수록 좋음.  
학습을 잘못했을 경우 사회적인 이슈가 있는 대답을 할 가능성도 있음.
범용성은 높고 신뢰도를 높일 수 있는 가능성도 높음

## 시중에 나와있는 봇들

### 특정영역 봇

- [법률] [DoNotPay (IBM Watson 기반)](https://www.donotpay.com/): 주차위반 딱지 발급 철회를 위한 법률 검토 서비스
- [금융] SORi: 우리은행 뱅킹 챗봇. 네이버 Clova 기반. Rule Based
- [유통] GS25 지니

### 범용 봇

- Amazon Alexa
- Google Assistant

## 챗봇으로 할 수 있는 일들

| 분야 | 종류 | 관련 기업 |
|----|----|----|
| 대화형 커머스 및 O2O | 쇼핑, 비행기 예약, 숙소예약, 레스토랑 예약, 택시호출 등 | Amazon, eBay, FB, 카카오, 인터파크 |
| 개인비서 서비스 | 헬스케어, 뉴스피드, 날씨, 금융상담, 길찾기, 일정관리, 길 찾기 등 | Google, MS, Pancho, CNN, 샤오빙, Skype |
| 공공서비스 | 법률상담, 세금납부, 부동산정보, 구인구직 | 법무부, 경기도 정보기획실, 미야(Mya) |
| 엔터테인먼트 | 광고, 미디어, 방송안내, 데이팅, 공연 등 | WeChat |
| 기업용 메신저 | 정보검색, 파일공유, OA, CRM, 팀원정보 공유 | Slack, CareerLark, Growbot, Wework |

## 한글 전처리

- Corpus(말뭉치): 컴퓨터가 읽을 수 있는 형태로 저장된 일정 규모 이상의 언어자료
- 챗봇을 학습한다 = 코퍼스에서 어휘 및 특성을 추출하여 학습한다
- 한글은 영어에 비해 자연어처리의 난이도가 높다
  - 구어, 문어 사이에 큰 차이가 있음
  - 높임법
  - 주어/서술어/목적어의 빈번한 생략
  - 띄어쓰기 복잡함

### 필요한 작업들

- 전처리/단어 추출
  - Pandas
  - 오탈자, 띄어쓰기 교정
  - KoNLPy, soynlp
  - ...

- 단어 간 관계추론
  - TF-IDF
  - Word Embedding
  - Topic Modeling
  - NER
  - ...

### 오탈자 교정

Levenshtein distance. 가장 대표적인 String Distance Metric. 단어 A에서 B로 수정하기 위한 횟수를 거리고 정의함.

## 실습 예제

강의자료 받는 방법

```bash
docker pull themuser/chatbot:1.1
docker run -it --name chatbot -v /my-dir:/chatbot themuser/chatbot:1.1
```

### [Day-1](day-1.md)

### [Day-2(Deep Learning)](day-2-deep-learning.md): Deep Learning

### [Day-3](day-3.md): TensowFlow, RNN