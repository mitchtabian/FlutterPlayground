package com.codingwithmitch.firstflutterapp

const val QUESTION: String = "question"
const val ANSWERS: String = "answer"

class Test{

    var total: Int = 0

    fun add(value: Int){
        total += value
        println(total)
    }

    fun doThing(function: () -> Unit){
        function()
    }

    fun main(){

        doThing {add(2)}


//        val answersMap: Array<Map<String, Any>> = arrayOf(
//                mapOf(
//                        QUESTION to "Is Florian really my son?",
//                        ANSWERS to arrayOf("yes", "no")
//                ),
//                mapOf(
//                        QUESTION to "Who's your favorite android teacher?",
//                        ANSWERS to arrayOf("Coding with Mitch", "Coding In Flow", "Donn Felker", "Nate Ebel")
//                )
//        )
//
//
//        val answers: Array<String>  = answersMap[0][ANSWERS] as Array<String>
//
//        for(answer in answers){
//            println(answer)
//        }
    }




}