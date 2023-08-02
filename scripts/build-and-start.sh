cargo build --target x86_64-unknown-linux-gnu --release || exit

docker compose build || exit
docker compose up || exit
