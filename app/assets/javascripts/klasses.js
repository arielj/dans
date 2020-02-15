onLoad(function(){
  let assignTeachersBtn = byid('open-teachers-modal');
  if (assignTeachersBtn) {
    let teachersList = byid('teachers');

    assignTeachersBtn.addEventListener('click', e => {
      e.preventDefault();
      let title = e.target.dataset.modalTitle;
      let content = byid('teachers-modal').innerHTML;
      let confirmBtn = document.createElement('button');
      confirmBtn.innerText = 'Aceptar';
      confirmBtn.classList.add('btn');
      modal = showModal(title, content, confirmBtn);

      teachersList.querySelectorAll('input[type=hidden]').forEach( i => {
        modal.querySelector('#teacher_ids_' + i.value).checked = true;
      })

      confirmBtn.addEventListener('click', e2 => {
        teachersList.innerHTML = '';
        modal.querySelectorAll('input[type=checkbox]:checked').forEach( t => {
          let input = `<input type='hidden' name='klass[teacher_ids][]' value='${t.value}' />`;
          let span = `<span>${t.nextSibling.wholeText}</span>`;
          let teacherDiv = document.createElement('div');
          teacherDiv.classList.add('teacher');
          teacherDiv.insertAdjacentHTML('beforeend', input);
          teacherDiv.insertAdjacentHTML('beforeend', span);
          teachersList.appendChild(teacherDiv);
        })
        closeModal();
      })
    })
  }
})