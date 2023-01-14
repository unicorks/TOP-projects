window.addEventListener("load", function(){
    let operatorClicked = false
    let currentTotal = 0;

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
            operatorClicked = true;
            operation = this.id
        })
    })
    numbers = document.querySelectorAll('.number')
    numbers.forEach(number => {
        number.addEventListener('click', function(){
            let display = document.querySelector('.display')
            displayNumber = parseFloat(display.innerText)
            buttonValue = this.id 
            // try to figure out calculator behaviour
        })
    })
})