# flutter_with_clean_architecture

<br>
<br>
<br>
<br>

<p align="center"> <img src="https://user-images.githubusercontent.com/40454769/141642218-7bd8cb49-040b-45aa-976a-74cfcbdd8567.png"  width="500" height="500"/> </p
                                                                                                                                         
<br>
<br>
  
<p align="center"> <img src="https://user-images.githubusercontent.com/40454769/141642204-e7bc159e-ed8f-49a5-8966-0fc70fab0b8a.png"  width="500" height="500"/> </p

  App에서의 한 기능은 3개의 layer _**(presentation, domain, data)**_ 로 구성된다.
  
<br>


### Presentation
screen에 widget을 보여주고, 예를들어 Bloc를 사용하는 경우 event를 보내거나 state를 listen한다. Presentation Logic Holder(e.g. Bloc)는 많은 것을 하지않고 대부분을 use case가 대신 하도록한다.

  <br>

### Domain
data source에 영향을 받지 않아야한다.
business logic(use cases), business objects(entities)가 포함되어 있고, 다른 모든 layer에 완전히 독립적이어야한다.
* _**use cases**_

  App의 특정한 use case의 business logic을 캡슐화한 class 이다.

data를 가져올때 data layer에도 속해있는 repository에서 가져오기 때문에 layer간의 독립성을 유지하기 위해서 dependency inversion을 이용한다.
* _**Dependency inversion principle**_

  SOLID principles의 마지막 원칙으로 layer간의 경계는 interface로 처리해야한다고 말하고 있다.

domain layer에 repository가 수행해야하는 작업을 정의하는 abstract repository class를 생성한다.

  <br>

### Data
data layer는 Repository implementation 과 data sources로 구성된다.
data sources는 Entities가 아니라 Models를 return 한다.


<br>
<br>
<br>

#### Reference
[[resocoder] - Flutter TDD Clean Architecture Course](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
