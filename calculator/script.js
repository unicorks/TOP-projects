window.addEventListener("load", function(){
    let operatorClicked = false
    let operation = 'e'
    let num1 = 0;
    let num2 = 0

    function operate(num1, num2, operator) {
        if (operator==='add') {
            return num1 + num2
        }
        if (operator==='subtract') {
            return num1 - num2
        }
        if (operator==='multiply') {
            return num1 * num2
        }
        if (operator==='divide') {
            return num1 / num2
        }
    }

    operators = document.querySelectorAll('.operator')
    operators.forEach(operator => {
        operator.addEventListener('click', function(){
            let display = document.querySelector('.display')
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
            // try to figure out calculator behaviour
            // to do: put everything in display, use split and then operate when user presses another op or equals to.
            if (operatorClicked===false){
                display.innerText += buttonValue
                num1 = parseFloat(display.innerText)
            }
            if (operatorClicked===true){
                num2 = display.innerText.split(/[+-×÷]/)[1]
            }
        })
    })
})