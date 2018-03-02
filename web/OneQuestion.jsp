<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "javabeans.QuestionBean" %>
<jsp:useBean id = "questionId" scope = "session"  class = "javabeans.QuestionBean">
     <jsp:setProperty name="questionId" property="enteredAnswers" value="<%= request.getParameterValues("answer")%>" />
</jsp:useBean>
<jsp:setProperty name = "questionId" property = "*" />
<% questionId.initializeJdbc(); %>
<% questionId.loadQuestion(request.getParameter("chapterNo"), request.getParameter("questionNo")); %>
<!DOCTYPE html>
<html>
    <head>
        <title>Multiple Choice Question</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
        <style type = "text/css">
            body {font-family: "Courier New", sans-serif; font-size: 100%; color: black}
            .keyword {color: #000080; font-weight: normal}
            .comment {color: gray}
            .literal {font-weight: normal; color: #3366FF}
        </style>
        <link rel="stylesheet" type="text/css" href="intro6e.css" />
        <link rel="stylesheet" type="text/css" href="intro6eselftest.css" />
        <link rel="stylesheet" type="text/css" href="color.css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
        <script>hljs.initHighlightingOnLoad();</script>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <style> 
            #question {font-family: "Courier New", Courier, Verdana, Helvetica, sans-serif; font-size: 100%; 
                       color: #8000f0; color: black; margin-left: 0.5em}
            #questionstatement {font-family: 
                                    Times New Roman, monospace, Courier, Verdana, Helvetica, sans-serif; font-size: 100%; color: #8000f0; 
                                color: black; margin-left:1.8em; margin-top:0.5em; margin-bottom:0.5em; }
            #choices {font-family: Times New Roman, Helvetica, sans-serif; font-size: 100%; 
                      color: #8000f0; color: black; margin-left:25.0pt; margin-left:0.5em; margin-bottom:0.5em; }
            #choicemargin {font-family: Times New Roman, Helvetica, sans-serif; font-size: 100%; }
            #choicestatement {font-family: Times New Roman, Helvetica, sans-serif; font-size: 100%; 
                              color: #8000f0; color: black; margin-left:25.0pt; margin-left:0.5em; margin-bottom:0.5em; }
            .preBlock {margin-left:0px;text-indent:0.0px; font-family:monospace; font-size: 120%}
            .keyword {color: green;}
            .comment {color: darkred;  }
            .literal {color: darkblue}
            .constant {color: teal}
            #h3style {color: white; font-family: Helvetica, sans-serif;  font-size: 100%; border-color: #6193cb; text-align: center;margin-bottom: 0.5em; background-color: #6193cb;}  
        </style>
    <h3 id="h3style" style = " width: 500px auto; max-width: 820px; margin: 0 auto; ">
        Multiple Choice Question <%= request.getParameter("title") %>
    </h3>
    <div style="width: 500px auto; max-width: 820px; margin: 0 auto; border: 1px solid #f6912f; font-weight: normal ">
        <form method="post" style="padding-left: 10px; padding-bottom: 10px; padding-top: 10px"> 
              <%String question = "";
                String questionCode = "";
                String fullQuestion = questionId.getQuestionText();
                String[] parts = fullQuestion.trim().split("\n", 2);
                question = parts[0];
                
                if(parts.length > 1){
                    questionCode = parts[1];
                }
              %><div style="font-family: Times New Roman">  <%= question %> </div>
              <div id="question"> <pre><code><%= questionCode %></code></pre> </div>
              
                <%
                int numAnswers = questionId.getNumberOfAnswers();
                String key = questionId.getAnswerKey();
                String choiceA = questionId.stringToHTMLString(questionId.getChoiceA());
                String choiceB = questionId.stringToHTMLString(questionId.getChoiceB());
                String choiceC = questionId.stringToHTMLString(questionId.getChoiceC());
                String choiceD = questionId.stringToHTMLString(questionId.getChoiceD());
                String choiceE = questionId.stringToHTMLString(questionId.getChoiceE());

                if (numAnswers == 2){
                    if(key.length() > 1){
                        %><div id = "choicemargin"><input type="checkbox" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                    <%}
                    else{
                        %><div id = "choicemargin"><input type="radio" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                    <%}
                }
                if (numAnswers == 3){
                    if(key.length() > 1){
                        %> <div id = "choicemargin"><input type="checkbox" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="C" name="answer"><span id="choicelabel">C.</span> <span id="choicestatement"> <%= choiceC %> </span><br></div>
                    <%}
                    else{
                        %><div id = "choicemargin"><input type="radio" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="C" name="answer"><span id="choicelabel">C.</span> <span id="choicestatement"> <%= choiceC %> </span><br></div>
                    <%}
                }
                if (numAnswers == 4){
                    if(key.length() > 1){
                        %> <div id = "choicemargin"><input type="checkbox" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="C" name="answer"><span id="choicelabel">C.</span> <span id="choicestatement"> <%= choiceC %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="D" name="answer"><span id="choicelabel">D.</span> <span id="choicestatement"> <%= choiceD %> </span><br></div>
                    <%}
                    else{
                        %><div id = "choicemargin"><input type="radio" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="C" name="answer"><span id="choicelabel">C.</span> <span id="choicestatement"> <%= choiceC %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="D" name="answer"><span id="choicelabel">D.</span> <span id="choicestatement"> <%= choiceD %> </span><br></div>
                    <%}
                }
                if (numAnswers == 5){
                    if(key.length() > 1){
                        %> <div id = "choicemargin"><input type="checkbox" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="C" name="answer"><span id="choicelabel">C.</span> <span id="choicestatement"> <%= choiceC %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="D" name="answer"><span id="choicelabel">D.</span> <span id="choicestatement"> <%= choiceD %> </span><br></div>
                        <div id = "choicemargin"><input type="checkbox" value="E" name="answer"><span id="choicelabel">E.</span> <span id="choicestatement"> <%= choiceE %> </span><br></div>
                    <%}
                    else{
                        %><div id = "choicemargin"><input type="radio" value="A" name="answer"><span id="choicelabel">A.</span> <span id="choicestatement"> <%= choiceA %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="B" name="answer"><span id="choicelabel">B.</span> <span id="choicestatement"> <%= choiceB %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="C" name="answer"><span id="choicelabel">C.</span> <span id="choicestatement"> <%= choiceC %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="D" name="answer"><span id="choicelabel">D.</span> <span id="choicestatement"> <%= choiceD %> </span><br></div>
                        <div id = "choicemargin"><input type="radio" value="E" name="answer"><span id="choicelabel">E.</span> <span id="choicestatement"> <%= choiceE %> </span><br></div>
                    <%}
                }
            %>
            <%  String[] selectedAnswers = request.getParameterValues("answer");
                if(selectedAnswers != null){
                    StringBuilder build = new StringBuilder();
                    for(String thing : selectedAnswers){
                        build.append(thing);
                    }
                    //Correct answer selected
                    if(build.toString().equalsIgnoreCase(key)){
                        out.print("<span style=\"color: green; font-family: Helvetica, sans-serif\" > Your answer " + build.toString() + " is correct. </span><img src=\"images/correct.jpg\" alt=\"Wrong\"> <br>");
                            //Insert results into db
                            boolean bitA = false;
                            boolean bitB = false;
                            boolean bitC = false;
                            boolean bitD = false;
                            boolean bitE = false;
                            boolean isCorrect = true;
                            for(int i = 0; i < selectedAnswers.length; i++){
                                 if (selectedAnswers[i].equalsIgnoreCase("A")){
                                     bitA = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("B")){
                                     bitB = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("C")){
                                     bitC = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("D")){
                                     bitD = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("E")){
                                     bitE = true;
                                 }
                            }
                            questionId.insert(isCorrect, request.getRemoteAddr(), bitA, bitB, bitC, bitD, bitE, request.getRemoteAddr());
                            
                            if(questionId.getHint().length() > 0){
                                out.print("<div id=\"a3\" style=\"color: green; font-family: Helvetica, sans-serif\" > Click here to show an explanation. </div><br>");
                                out.print("<script type=\"text/javascript\">$(document).ready(function() {$(\"#a3\").click(function() {$(this).html(\"<div style = 'color: purple; font-family: Times New Roman;'> Explanation: " 
                                    + questionId.getHint() + "</div>\");});});</script> ");  
                        }
                    }
                    else{
                        //Wrong answer selected
                        if(!build.toString().equalsIgnoreCase(key)){
                            out.print("<span style=\"color: red; font-family: Helvetica, sans-serif\" > Your answer " + build.toString() + " is wrong. </span><img src=\"images/wrong.jpg\" alt=\"Wrong\"> <br>");
                            //Insert results into db
                            boolean bitA = false;
                            boolean bitB = false;
                            boolean bitC = false;
                            boolean bitD = false;
                            boolean bitE = false;
                            boolean isCorrect = false;
                            for(int i = 0; i < selectedAnswers.length; i++){
                                 if (selectedAnswers[i].equalsIgnoreCase("A")){
                                     bitA = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("B")){
                                     bitB = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("C")){
                                     bitC = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("D")){
                                     bitD = true;
                                 }
                                 if (selectedAnswers[i].equalsIgnoreCase("E")){
                                     bitE = true;
                                 }
                            }
                            questionId.insert(isCorrect, request.getRemoteAddr(), bitA, bitB, bitC, bitD, bitE, request.getRemoteAddr());
                            
                            if(questionId.getHint().length() > 0){
                                out.print("<div id=\"a3\" style=\"color: green; font-family: Helvetica, sans-serif\" > Click here to show an explanation. </div><br>");
                                out.print("<script type=\"text/javascript\">$(document).ready(function() {$(\"#a3\").click(function() {$(this).html(\"<div style = 'color: purple; font-family: Times New Roman;'> Explanation: " 
                                    + questionId.getHint() + "</div>\");});});</script> ");
                            }
                        }
                    }
                }
                else{
                    //Takes care of trying to submit without selecting an answer, will not submit to intro11e DB
                    if((request.getParameter("buttonName") != null)){                    
                        out.print("<span style=\"font-family: Helvetica, sans-serif\"> You did not answer this <img src=\"images/noanswer.jpg\" alt=\"No answer\"> </span><br>");
                        if(questionId.getHint().length() > 0){
                            out.print("<div id=\"a4\" style=\"color: green; font-family: Helvetica, sans-serif\" > Click here to show correct answer and explanation. </div><br>");
                            out.print("<script type=\"text/javascript\">$(document).ready(function() {$(\"#a4\").click(function() {$(this).html(\"<span style= 'color: green; font-family: Helvetica, sans-serif;' > The correct answer is " + questionId.getAnswerKey() + "</span><br>" + "<div style = 'color: purple; font-family: Times New Roman;'> Explanation: " 
                                    + questionId.getHint() + "</div>\");});});</script> ");
                        }
                        else{
                            out.print("<div id=\"a4\" style=\"color: green; font-family: Helvetica, sans-serif\" > Click here to show correct answer. </div><br>");
                            out.print("<script type=\"text/javascript\">$(document).ready(function() {$(\"#a4\").click(function() {$(this).html(\"<div style = 'color: green; font-family: Helvetica, sans-serif;'> The correct answer is " 
                                    + questionId.getAnswerKey() + "</div>\");});});</script> ");
                        }
                    }
                }
            %>
            <input type="submit" style = "margin-bottom: 0px; margin-top: 10px; margin-left: 5px;border: 0px; font-family: Helvetica, monospace; font-size: 85%;background-color: rgba(0, 128, 0, 0.7); border-radius: 0px; color:black;"name = "buttonName" value= "Check My Answer">
        </form>
    </div>

    </head>
    <body>

    </body>
</html>
