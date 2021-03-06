//Graph area
(function($) {
  $.widget("environment.graphArea", {
    options: {
      onElementDrop: function(event, params){
        //Triggers onElementDrop event on draggable that was dropped on this droppable
        params.args.draggable.trigger('onElementDrop', params);
      }
    },
    instances: [],
    instanceCount: 0,
    _create: function() {
      var self = this;
      var element = self.element;
      element.droppable({
        //The classes of draggables to be accepted
        accept: '.resourceDraggable',
        drop: function(event, ui){
          self._trigger('onElementDrop', event , { args: ui, droppable: $(this)} );

        }
      });
      self._trigger('onCreate');
    },
    addInstanceToStage: function(instanceElement, instanceId){
      instanceElement.appendTo(this.element);
      //Give ID to the new element
      if(instanceId != "undefined") {
        if(this.instanceCount <  instanceId)
          this.instanceCount = instanceId;
        else
          this.instanceCount++;
      }
      else{
        this.instanceCount++;
      }
      instanceElement.attr('id', 'instance-' + this.instanceCount );
      this.instances.push(instanceElement);
    },
    save: function(environmentAttributes){
      var instances = this.instances;
      var instanceAttributes = [];
      for(var i = 0; i < instances.length; i++)
        instanceAttributes.push(instances[i].instance("getAttributes"));
      showLoading();
      $.ajax({
        url: $('#graph-save-frm').attr('action'),
        type: 'POST',
        dataType: "script",
        contentType: 'application/json',
        data: JSON.stringify({environment: environmentAttributes, instances: instanceAttributes})
      });
    },
    update: function(graphId){
      var instances = this.instances;
      var instanceAttributes = [];
      for(var i = 0; i < instances.length; i++)
        instanceAttributes.push(instances[i].instance("getAttributes"));
      showLoading();
      $.ajax({
        url: $('#graph-save-frm').attr('action')+'/'+graphId,
        type: 'PUT',
        dataType: "script",
        contentType: 'application/json',
        data: JSON.stringify({instances: instanceAttributes}),
        complete: function(){
          hideLoading();
        }
      });
    },
    getInstances: function(){
      var instances = this.instances;
      var instanceAttributes = [];
      for(var i = 0; i < instances.length; i++)
        instanceAttributes.push(instances[i].instance("getAttributes"));
      return(JSON.stringify({instances: instanceAttributes}));
    },
    getInstanceElementByLabel: function(label){
      var instances = this.instances;
      for(var i = 0; i < instances.length; i++){
        if(instances[i].instance('option', 'label') == label)
          return instances[i];
      }
    },
    removeInstanceFromStage: function(instanceId){
      var instances = this.instances;
      for(var i = 0; i < instances.length; i++)
      {
        if(instances[i].attr('id') == instanceId)
          instances[i].instance("destroy");
      }
    },
    destroy: function() {
      this.element.remove();
    }

  });
})(jQuery);
