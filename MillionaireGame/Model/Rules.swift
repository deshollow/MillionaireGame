//
//  Rules.swift
//  MillionaireGame
//
//  Created by deshollow on 15.04.2024.
//

import Foundation

let rules: String = """
Для того чтобы заработать 1 миллион рублей, необходимо правильно ответить на 15 вопросов из различных областей знаний. Каждый вопрос имеет 4 варианта ответа, из которых только один является верным. Каждый вопрос имеет конкретную стоимость.
Вопросы разделены на 3 уровня сложности:

* С 1-го по 5-й — простые вопросы, ответить на которые не составит труда.
* С 6-го по 10-й — вопросы средней сложности общей тематики.
* С 11-го по 15-й — сложные вопросы, требующие знаний в отдельных областях.

Все суммы являются заменяемыми, то есть после ответа на следующий вопрос не суммируются с суммой за ответ на предыдущий.

Существуют несгораемые суммы, которые можно получить ответив правильно на 5 вопрос (1000 рублей) и на 10 вопрос (32000 рублей).

Игра заканчивается в случае нажатия на неверный ответ.

Вы можете забрать деньги, нажав на кнопку "Забрать деньги". В этом случае Вы получите сумму, равную предыдущему вопросу.

Подсказки

 Подсказку можно использовать только один раз за всю игру до дачи ответа на заданный определённый вопрос.

1. «50 на 50» — компьютер убирает два неправильных ответа, предоставляя игроку выбор из оставшихся двух вариантов ответа.
2. «Звонок другу» —  будет подсвечен правильный вариант с вероятностью 80%
3. «Помощь зала»  —  будет подсвечен правильный вариант с вероятностью 70%
4. «Право на ошибку» — если игрок ответил неверно игра будет продолжена
"""
