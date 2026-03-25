Tạo video bài tập:
1. Mở Window Powershell (Run as Administrator).
2. Cài đặt chocolatey theo [hướng dẫn](https://chocolatey.org/install#individual).
3. Cài đặt ffmpeg bằng cách chạy `choco install ffmpeg`.
4. Trong thư mục hình ảnh đã tạo, mở `cmd` và chạy `ffmpeg -framerate 30 -i img%03d.png -c:v libx264 -pix_fmt yuv420p -r 30 output.mp4`
