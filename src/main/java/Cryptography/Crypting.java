package Cryptography;

/**
 *
 * @author alptugaltin
 */
import java.util.Base64;

public class Crypting {

    public byte[] Encrypt(String userData) throws Exception {
        byte[] encodedBytes = Base64.getEncoder().encode(userData.getBytes());
        
        return encodedBytes;
    }

    public byte[] Decrypt(byte[] encryptedData) throws Exception {
        byte[] decodedBytes = Base64.getDecoder().decode(encryptedData);
        
        return decodedBytes;
    }

    public static void main(String args[]) throws Exception {
        Crypting a = new Crypting();
        
        byte[] data = a.Encrypt("Kullanıcı Adı");
        String nweData = new String(a.Decrypt(data));
        
        System.out.println(data);
        System.out.println(nweData);
    }
}
