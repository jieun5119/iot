import processing.serial.*;
import processing.net.*;

Serial p; 
Server s; 
Client c; 
void setup() {
s = new Server(this, 1234); 
p = new Serial(this, "COM9", 9600); // 포트번호 9번 아두이노와 연결
}
String msg;
void draw() {
c = s.available();
if (c!=null) { 
String m = c.readString(); // 클라이언트에서 보낸 문자열을 받는다
if (m.indexOf("PUT")==0) { 
int n = m.indexOf("\r\n\r\n")+4;
m = m.substring(n);
m += '\n';
print(m); // 서버 화면 출력하기
p.write(m); // 아두이노에 값을 보내기
}
else if (m.indexOf("GET")==0) { 
c.write("HTTP/1.1 200 OK\r\n"); 
c.write("Content-length: " + msg.length() + " \r\n\r\n"); 
c.write(msg); // 클라이언트에 값 주기
}
}
if (p.available()>0) {
String m = p.readStringUntil('\n'); 
if (m!=null) {
msg = m;
print(m);
}
}
}
