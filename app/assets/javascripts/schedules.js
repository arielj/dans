function bindSchedulesCalendar() {
  const filter = byid('filter_schedules');
  if (filter) {
    filter.addEventListener('input', function(e) {
      const val = this.value;
      const regexp = new RegExp(".*" + val + ".*", 'i');
      const schs = this.parentElement.qsa('.day label');
      schs.forEach( sch => {
        cls = sch.classList;
        if (val !== '') {
          if (regexp.test(sch.innerText)) cls.remove('hidden');
          else cls.add('hidden');
        } else {
          cls.remove('hidden');
        }
      })
    });
  }
};

onLoad(bindSchedulesCalendar);
