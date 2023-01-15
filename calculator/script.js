window.addEventListener("load", function(){
    let operatorClicked = false
    let operation = 'e'
    let num1 = 0;
    let num2 = 0

    function operate(num1, num2, operator) {
        if (operator==='+') {
            return num1 + num2
        }
        if (operator==='-') {
            return num1 - num2
        }
        if (operator==='×') {
            return num1 * num2
        }
        if (operator==='÷') {
            return num1 / num2
        }
    }
    
    // HOW IT WORKS: put everything in display, use split and then operate when user presses another op or equals to.
    operators = document.querySelectorAll('.operator')
    operators.forEach(operator => {
        operator.addEventListener('click', function(){
            let display = document.querySelector('.display')
            if (operatorClicked === true) {
                let temp = display.innerText.search(/[^0-9]/)
                operation = display.innerText[temp]
                num1 = operate(num1, num2, operation)
                display.innerText = num1
                operatorClicked = false
            }
            if (this.id==='add'){display.innerText += '+'}
            if (this.id==='subtract'){display.innerText += '-'}
            if (this.id==='multiply'){display.innerText += '×'}
            if (this.id==='divide'){display.innerText += '÷'}
            operatorClicked = true
        })
    })
    numbers = document.querySelectorAll('.number')
    numbers.forEach(number => {
        number.addEventListener('click', function(){
            let display = document.querySelector('.display')
            buttonValue = this.id 
            if (operatorClicked===false){
                display.innerText += buttonValue
                num1 = parseFloat(display.innerText)
            }
            if (operatorClicked===true){
                display.innerText += buttonValue
                num2 = parseFloat(display.innerText.split(/[^0-9]/)[1])
            }
        })
    })

    document.querySelector('.clear').addEventListener('click', function(){
        document.querySelector('.display').innerText = 0
        num1 = 0
        num2 = 0
    })
    document.querySelector('.equals').addEventListener('click', function(){
        if (operatorClicked===false) {
            return
        }
        let display = document.querySelector('.display')
        let temp = display.innerText.search(/[^0-9]/)
        operation = display.innerText[temp]
        num1 = operate(num1, num2, operation)
        display.innerText = num1
        operatorClicked = false
    })
})