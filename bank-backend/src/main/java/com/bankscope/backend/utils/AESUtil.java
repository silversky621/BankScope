package com.bankscope.backend.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

@Component
public class AESUtil {

    // 16byte 키. 소스에 박지 않고 외부 설정(application.properties / 환경변수)에서 주입한다.
    // 정적 메서드(encrypt/decrypt) 호출부를 유지하기 위해, Spring이 setter로 주입한 값을 static 필드에 보관한다.
    private static String SECRET_KEY;

    @Value("${app.aes.secret-key}")
    public void setSecretKey(String secretKey) {
        AESUtil.SECRET_KEY = secretKey;
    }

    public static String encrypt(String plainText) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), "AES");
            // ECB 모드는 IV가 필요 없고, 같은 평문이면 항상 같은 암호문이 나와 검색에 용이함
            // (보안 수준은 CBC보다 낮지만, DB 검색이 필요한 경우 타협안으로 사용)
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding"); 
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            byte[] encryptedBytes = cipher.doFinal(plainText.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(encryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String decrypt(String encryptedText) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
            return new String(decryptedBytes, "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
