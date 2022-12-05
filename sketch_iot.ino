void setup(){
Serial.begin(9600); // 시리얼을 시작
pinMode(13, OUTPUT); // 핀을 13번에 led를 꽂고 사용
}

double th(int v) { // 온도계의 값을 섭씨로 변환double t;
t = log(((10240000/v) - 10000));
t = 1 /(0.001129148 + (0.000234125*t) + (0.0000000876741*t*t*t));
t = t - 273.15; // 화씨 -> 섭씨로 변경
return t;
}
void loop(){
int a=analogRead(A0); //  온도계가 온도를 측정
Serial.println(th(a)); //  온도값을 서버로 전달
int a = (Serial.readString()).toInt(); // 클라이언트에서 보낸 값을 서버에서 보낸것을 받음
digitalWrite(13, HIGH); // led 켜기
delay(a); // 받은 a의 값만큼 쉬기 
digitalWrite(13, LOW); // led를 끄기
delay(a); // 받은 a의 값만큼 쉬기
}