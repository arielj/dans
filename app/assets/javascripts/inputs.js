onLoad(function() {
  qsa('.amount-input').forEach( el => bindAmountField(el) );
})

function bindAmountField(input) {
  if (input)
    input.addEventListener('keypress', e => {
      let inp = e.target;
      if (e.key.length == 1) {
        let separator = inp.value.match(/[.,]/);
        if (separator)
          if (inp.selectionStart > separator.index && inp.selectionEnd > separator.index)
            if (inp.value.match(/^\d+[.,]\d{2}$/))
              e.preventDefault();

        if (!e.key.match(/[\d\,\.]/))
          e.preventDefault();

        if (e.key.match(/[.,]/) && (inp.value.match(/[.,]/) || inp.value == ''))
          e.preventDefault();
      }
    })
}