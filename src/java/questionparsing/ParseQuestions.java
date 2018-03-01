package questionparsing;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.regex.*;

public class ParseQuestions {

    private final int numChapters = 44;
    private int chapters;
    private static PreparedStatement preparedStatementInsert;

    public ParseQuestions() {
        //printQuestionList();
        
        //Initialize JDBC
        try {
                //Load Driver
                Class.forName("com.mysql.jdbc.Driver");
                System.out.println("Driver loaded.");

                //Connect Database
                Connection connection = DriverManager.getConnection("jdbc:mysql://35.185.94.191/btran", "btran", "tiger");
                System.out.println("Database connected.");
                String query = "insert into intro11equiz values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                preparedStatementInsert = connection.prepareStatement(query);
            } catch (Exception ex) {
                ex.printStackTrace();
            }   
        insertIntoDb();
    }

    static class Question {

        int chapterNo;
        int questionNo;
        String questionText;
        String choiceA;
        String choiceB;
        String choiceC;
        String choiceD;
        String choiceE;
        String answerKey;
        String hint;
        //PreparedStatement preparedStatementInsert;

//        public void initializeJdbc() {
//            try {
//                //Load Driver
//                Class.forName("com.mysql.jdbc.Driver");
//                System.out.println("Driver loaded.");
//
//                //Connect Database
//                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/btran", "root", "rootpass");
//                System.out.println("Database connected.");
//                String query = "insert into intro11equiz values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//                preparedStatementInsert = connection.prepareStatement(query);
//            } catch (Exception ex) {
//                ex.printStackTrace();
//            }
//        }

        public void insert() throws SQLException {
            preparedStatementInsert.setString(1, String.valueOf(getChapterNo()));
            preparedStatementInsert.setString(2, String.valueOf(getQuestionNo()));
            preparedStatementInsert.setString(3, getQuestionText());
            preparedStatementInsert.setString(4, getChoiceA());
            preparedStatementInsert.setString(5, getChoiceB());
            preparedStatementInsert.setString(6, getChoiceC());
            preparedStatementInsert.setString(7, getChoiceD());
            preparedStatementInsert.setString(8, getChoiceE());
            preparedStatementInsert.setString(9, getAnswerKey());
            preparedStatementInsert.setString(10, getHint());
            preparedStatementInsert.executeUpdate();
            System.out.println("inserted");
        }

        @Override
        public String toString() {
            return chapterNo + "\n"
                    + questionNo + "\n"
                    + questionText + "\n"
                    + choiceA + "\n"
                    + choiceB + "\n"
                    + choiceC + "\n"
                    + choiceD + "\n"
                    + choiceE + "\n"
                    + answerKey + "\n"
                    + hint + "\n";
        }

        public int getChapterNo() {
            return chapterNo;
        }

        public void setChapterNo(int chapterNo) {
            this.chapterNo = chapterNo;
        }

        public int getQuestionNo() {
            return questionNo;
        }

        public void setQuestionNo(int questionNo) {
            this.questionNo = questionNo;
        }

        public String getQuestionText() {
            return questionText;
        }

        public void setQuestionText(String questionText) {
            this.questionText = questionText;
        }

        public String getChoiceA() {
            return choiceA;
        }

        public void setChoiceA(String choiceA) {
            this.choiceA = choiceA;
        }

        public String getChoiceB() {
            return choiceB;
        }

        public void setChoiceB(String choiceB) {
            this.choiceB = choiceB;
        }

        public String getChoiceC() {
            return choiceC;
        }

        public void setChoiceC(String choiceC) {
            this.choiceC = choiceC;
        }

        public String getChoiceD() {
            return choiceD;
        }

        public void setChoiceD(String choiceD) {
            this.choiceD = choiceD;
        }

        public String getChoiceE() {
            return choiceE;
        }

        public void setChoiceE(String choiceE) {
            this.choiceE = choiceE;
        }

        public String getAnswerKey() {
            return answerKey;
        }

        public void setAnswerKey(String answerKey) {
            this.answerKey = answerKey;
        }

        public String getHint() {
            return hint;
        }

        public void setHint(String hint) {
            this.hint = hint;
        }

    }

    public void insertIntoDb() {
        ArrayList<Question> inserter = new ArrayList();
        for (int i = 1; i <= numChapters; i++) {
            this.chapters = i;
            inserter = readQuestions("././questions/chapter" + i + ".txt");
            inserter.forEach(e -> {
                try {
                    e.insert();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            });     
        }
    }

    public void printQuestionList() {
        ArrayList read = null;
        int counter = 0;
        for (int i = 1; i <= numChapters; i++) {
            this.chapters = i;
            read = readQuestions("././questions/chapter" + i + ".txt");
            read.forEach(e -> System.out.println(e.toString()));
            //System.out.println(counter += read.size());
        }

    }

    private ArrayList<Question> readQuestions(String filename) {
        Pattern p = Pattern.compile("\\d{1,2}\\.\\s*(.*)$");
        Pattern answers = Pattern.compile("^[Kk]ey:([a-e]{1,5})\\s*(.*)$");//^[kK]ey:([a-e]+)\s*(.*)$
        Pattern choice = Pattern.compile("^[a-eA-E]\\.\\s*(.*)$");
        Pattern choiceA = Pattern.compile("^\\s*[Aa]\\.");
        Pattern newQuestion = Pattern.compile("#{1}\\s");
        Matcher matcher;
        Matcher questionMatcher;
        Matcher choiceAMatcher;
        Matcher choiceMatcher;
        String line;
        ArrayList<Question> questionList = new ArrayList<>();
        int questionCounter = 0;

        try {
            BufferedReader input = new BufferedReader(new FileReader(filename));
            
            //input.readLine();// Skip 
            //input.readLine();// Skip 
            input.readLine();// 4th line is the first real line of questions

            while ((line = input.readLine()) != null) {

                Question question = new Question();
                question.questionNo = ++questionCounter;
                question.chapterNo = chapters;
                StringBuilder description = new StringBuilder();
                if (line.startsWith("Section")) {
                    line = input.readLine(); //Discard section lines
                }
                while (!line.startsWith("#")) {
                    questionMatcher = newQuestion.matcher(line);
                    matcher = p.matcher(line);
                    choiceMatcher = choice.matcher(line);
                    choiceAMatcher = choice.matcher(line);
                    
                    if (matcher.matches()) {
                        description.append(matcher.group(1));
                        line = input.readLine();
                    } else if (line.startsWith("Section")) {
                        line = input.readLine(); //Discard section lines.
                    } else if (line.startsWith("a.") || line.startsWith("A.")) {
                        choiceMatcher.matches();
                        question.choiceA = choiceMatcher.group(1);
                        line = input.readLine();
                    } else if (line.startsWith("b.") || line.startsWith("B.")) {
                        choiceMatcher.matches();
                        question.choiceB = choiceMatcher.group(1);
                        line = input.readLine();
                    } else if (line.startsWith("c.") || line.startsWith("C.")) {
                        choiceMatcher.matches();
                        question.choiceC = choiceMatcher.group(1);
                        line = input.readLine();
                    } else if (line.startsWith("d.") || line.startsWith("D.")) {
                        choiceMatcher.matches();
                        question.choiceD = choiceMatcher.group(1);
                        line = input.readLine();
                    } else if (line.startsWith("e.") || line.startsWith("E.")) {
                        choiceMatcher.matches();
                        question.choiceE = choiceMatcher.group(1);
                        line = input.readLine();
                    } else if (line.startsWith("Key") || line.startsWith("key")) {
                        matcher = answers.matcher(line);
                        if (matcher.matches()) {
                            question.answerKey = matcher.group(1);
                            question.hint = matcher.group(2);
                            line = input.readLine();
                        }
                        // final description and question here
                        if ((line = input.readLine()) == null) {
                            question.questionText = description.toString();
                            questionList.add(question);
                            line = null;
                            return questionList;
                        }
                    } else {
                        description.append(line).append("\n");
                        line = input.readLine();
                    }
                }
                question.questionText = description.toString();
                questionList.add(question);
            }
            input.close();
        } catch (IllegalStateException | IOException ex) {
            System.out.println(ex.getMessage());
        } catch (NullPointerException ex) {
            System.out.println(ex.getMessage());
            // return questionList;
        }
        return questionList;
    }

    public static void main(String[] args) {
        ParseQuestions quizlist = new ParseQuestions();

    }
}
