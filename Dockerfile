FROM nginx:alpine

# 빌드 환경의 절대경로 대신 빌드 컨텍스트 기준 상대경로를 사용해야 어디서든 동일하게 재현할 수 있다.
COPY app/ /usr/share/nginx/html/

EXPOSE 80
