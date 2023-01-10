window.addEventListener("load", function(){
    let operatorClicked = false
    let currentValue = 0;
    document.querySelectorAll('.operator').addEventListener('click', function(){
        operatorClicked = true;
    })
    document.querySelectorAll('.number').addEventListener('click', function(){
        let display = document.querySelector('.display')
        if (display.innerText!==0 && operatorClicked === false){
            // simply puts the number in currentValue and adds digit to number
            buttonValue = 2 // FIX LATER
            display.innerText += buttonValue
            currentValue = parseFloat(display.innerText)
        }
    })
})