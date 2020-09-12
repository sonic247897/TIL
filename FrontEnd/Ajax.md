# Ajax

> (백엔드)서버와 데이터를 **소량 교환**하는 기술
>
> 백엔드를 JavaScript로 요청해서 결과(`데이터만 받는다. 뷰는 받지 않음`)를 **xml**이나 **json**으로 받아온다.

Ajax(Asynchronous`비동기` JavaScript and XML)는 서버와 데이터를 교환하는 기술의 하나이다.

Ajax는 클라이언트가 서버와 적은 양의 데이터를 교환하여 비동기적으로 HTML 페이지를 업데이트 할 수 있다.

이것은 전체 페이지를 다시 적재하지 않고 웹 페이지의 일부를 업데이트할 수 있다는 것을 의미한다.

(이전에는 데이터를 요청하면 서버에 갔다와서 위에서부터 전체페이지가 새로 로딩되었다. -> 기존 설정 작업들이 다 사라짐)

- 사용되는 곳 - 검색 자동완성, 지도 서비스(지도를 드래그해도 마커가 없어지지 않음), 숨겼다가 누르면 나오는 차트 등
  - 중복된 id체크에도 사용된다.

Ajax는 새로운 프로그래밍 언어가 아니라 다음과 같은 표준 기술을 사용하는 새로운 기술이다.

- HTML (컨텐츠)
- CSS (스타일)
- 자바스크립트, DOM (동적인 출력과 상호작용 담당)
- XML (데이터를 전송하기 위한 형식으로 사용)
  - 요즘은  xml -> json으로 변해가고 있는 추세: `json`은 가볍고, 문법은 CSS에 큰따옴표만 붙이면 된다.
- **XMLHttpRequest 객체** (서버와 비동기적으로 데이터를 교환하기 위해 사용)
  - Ajax 통신을 하기 위한 JavaScript의 핵심 객체. 하지만 우리는 jQuery와 Spring을 통해 ajax를 사용하므로 직접 쓰지는 않는다.



## 문법

> String 요청 - id check 정도
>
> ArrayList\<DTO> 요청 - 대부분의 경우

``` javascript
P{"color":"red";'a':[ .. ]}
// {} - json 객체(DTO)
// [] - json 배열(ArrayList)
```

​	=> Spring을 사용하면 라이브러리를 사용하지 않아도 된다. 또한, 어떻게 mapping되는지 신경 쓰지 않아도 된다.

- MIME 타입: **클라이언트 브라우저**가 인지하는 형식을 명시함 



## 기타

- 외부 json 데이터를 가공하거나 파싱해서 넘기고 싶을 때는 형식이 맞나(validate) 확인해야 한다. 

  => Json Validator 사이트에 접속해서 확인해본다.

- **[라이브러리]**

  - Spring을 사용하지 않는 경우 - `json.org` 사이트의 맨 아랫부분에는 프로그래밍 언어별 json parser가 있고, Java는 json-simple 라이브러리를 주로 사용한다.
  - Spring을 사용하는 경우 - https://mvnrepository.com/에서 라이브러리를 검색한다.
    - jackson core 2.4.6 : spring에서 사용하는 json parser, maker
    - jackson maker 2.4.6 : 자동으로 자바 object를 json으로 변환해줌