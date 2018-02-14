package questionparsing;

import java.util.stream.*;
import java.io.*;
import java.nio.file.*;
import java.util.List;
import java.util.ArrayList;

public class ParseQuestions {

    public static void main(String args[]) {
        String fileName = "././questions/chapter1.txt";

        List<String> list = new ArrayList<>();
        BufferedReader br = null;
        try {
            br = Files.newBufferedReader(Paths.get(fileName));
            String read = null;

            while ((read = br.readLine()) != null) {
                String[] split = (read.split("#"));

                for (String part : split) {
                    System.out.println(part);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                br.close();
            } catch (Exception e) {
            }
        }

        list.forEach(System.out::println);
    }
}
