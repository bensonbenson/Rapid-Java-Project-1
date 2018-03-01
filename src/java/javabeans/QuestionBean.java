
package javabeans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

public class QuestionBean {
    private String chapterNo, questionNo;
    private String questionText;
    private String choiceA;
    private String choiceB;
    private String choiceC;
    private String choiceD;
    private String choiceE;
    private String answerKey;
    private String hint;
    PreparedStatement preparedQuestion;
    PreparedStatement preparedInsert;
    ResultSet result;
    private String[] enteredAnswers;
    
    //Initialize Database
    public void initializeJdbc(){
        try{
            //Load Driver
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver loaded.");
            
            //Connect Database
            Connection connection = DriverManager.getConnection("jdbc:mysql://35.185.94.191/btran", "btran", "tiger");
            System.out.println("Database connected.");
            
            String queryQuestion = "select chapterNo, questionNo, question, choiceA, choiceB, choiceC, choiceD, choiceE, answerKey, hint from intro11equiz where chapterNo = ? && questionNo = ?";
            preparedQuestion = connection.prepareStatement(queryQuestion);
            
            String queryAdd = "insert into intro11e (chapterNo, questionNo, isCorrect, hostname, answerA, answerB, answerC, answerD, answerE, username) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            preparedInsert = connection.prepareStatement(queryAdd);
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
    //Selects question from database
    public void loadQuestion(String chapterNo, String  questionNo)throws SQLException{
        try{
            preparedQuestion.setString(1, chapterNo);
            preparedQuestion.setString(2, questionNo);
            result = preparedQuestion.executeQuery();
            
            while(result.next()){
                setChapterNo(result.getString(1));
                setQuestionNo(result.getString(2));
                setQuestionText(result.getString(3));
                setChoiceA(result.getString(4));
                setChoiceB(result.getString(5));
                setChoiceC(result.getString(6));
                setChoiceD(result.getString(7));
                setChoiceE(result.getString(8));
                setAnswerKey(result.getString(9));
                setHint(result.getString(10));
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
    //Insert answer selection to database
    public void insert(boolean isCorrect, String hostname, boolean a, boolean b, boolean c, boolean d, boolean e, String user)throws SQLException{
        try{
            preparedInsert.setString(1, getChapterNo());
            preparedInsert.setString(2, getQuestionNo());
            preparedInsert.setBoolean(3, isCorrect);
            preparedInsert.setString(4, hostname);
            preparedInsert.setBoolean(5, a);
            preparedInsert.setBoolean(6, b);
            preparedInsert.setBoolean(7, c);
            preparedInsert.setBoolean(8, d);
            preparedInsert.setBoolean(9, e);
            preparedInsert.setString(10, user);
            System.out.print(isCorrect);
            preparedInsert.execute();
            
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
    public int getNumberOfAnswers(){
        int num =2;
        if(getChoiceC() == null){
            return num;
        }
        else{
            if(getChoiceD() == null){
                num = 3;
            }
            else{
                if(getChoiceE() == null){
                    num = 4;
                }
                else{
                    num = 5;
                }
            }
        }
        return num;
    }

    public String getChapterNo() {
        return chapterNo;
    }

    public void setChapterNo(String chapterNo) {
        this.chapterNo = chapterNo;
    }

    public String getQuestionNo() {
        return questionNo;
    }

    public void setQuestionNo(String questionNo) {
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

    public String[] getEnteredAnswers() {
        return enteredAnswers;
    }

    public void setEnteredAnswers(String[] enteredAnswers) {
        this.enteredAnswers = enteredAnswers;
    }
    
}
