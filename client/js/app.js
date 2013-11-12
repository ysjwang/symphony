(function ($) {

  var Header = Backbone.View.extend({
    el: $('#app'),

    initialize: function() {
      _.bindAll(this, 'render');
      this.render();
    },
    render: function() {
      var template = _.template($('#header-template').html());
      $(this.el).prepend(template);
    }
  });

  var SignupPage = Backbone.View.extend({
    el: '#app',
    render: function() {
      var template = _.template($('#signup-template').html());
      this.$el.html(template);
    },
    events: {
      'click input[type=submit]': "submitForm"
    },
    submitForm: function(e) {
      e.preventDefault();
      $.ajax({
        url: 'http://localhost:3000/users',
        contentType: 'application/json',
        type: 'options',
        success: function() {
          alert('s');
        }
      });
    }
  });

  var Router = Backbone.Router.extend({
    routes: {
      '': 'signupPage'
    }
  });

  var signupPage = new SignupPage();
  var header = new Header();

  var router = new Router();
  router.on('route:signupPage', function() {
    signupPage.render();
  });

  Backbone.history.start();

} (jQuery));