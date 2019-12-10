onLoad(function(ev) {
  const form = qs('.edit_person');
  if (form) {
    let age = form.qs('input[name*=age]');
    if (age) {
      form.qs('input[name*=birthday]').addEventListener('change', function(ev) {
        const birthday = +new Date(this.value);
        const y = ~~((Date.now() - birthday) / 31557600000);
        age.value = y;
      });
      Rails.fire(age, 'change');
    }
    qs('.memberships select#membership').addEventListener('change', function(e) {
      getScript('/memberships/' + this.value);
    });
  }
});

function initFamilyAutocomplete() {
  let request = false;
  const familyForm = byid('add_family_member');
  const autocompleteOptions = familyForm.qs('#family_autocomplete');
  const q = familyForm.qs('#q');
  if (q) {
    q.addEventListener('input', function(e) {
      if (request) {
        request.abort();
        request = false;
      }

      const self = this;
      const p = this.parentNode;

      let div = p.qs('#autocomplete_selector');
      if (!div) {
        div = document.createElement('DIV');
        div.id = 'autocomplete_selector';
        p.appendChild(div);
      }

      onSelectClick = function(e) {
        e.preventDefault();
        byid('new_family_member_id').value = e.target.dataset.id;
        self.value = e.target.dataset.label;
        div.remove();
        autocompleteOptions.classList.remove('show');
        autocompleteOptions.innerHtml = '';
      };

      let val = this.value;
      if (val.length >= 3) {
        const path = this.dataset.autocompletepath;
        request = getJSON(path, {
          data: 'q='+val,
          success: function(response) {
            autocompleteOptions.innerHTML = '';
            response.forEach( person => {
              const option = document.createElement('span');
              option.innerText = `${person.label} (${person.value})`;
              option.dataset.label = person.label;
              option.dataset.id = person.value;
              option.addEventListener('click', onSelectClick);
              autocompleteOptions.appendChild(option);
            });

            if (response.length === 0)
              autocompleteOptions.innerHTML = '<div class="option">No hay resultados</div>';
            
            autocompleteOptions.classList.add('show');
          }
        });
      } else {
        div.innerHTML = '';
      }
    });
  }
}
