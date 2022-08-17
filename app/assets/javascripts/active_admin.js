//= require arctic_admin/base
$( window ).on( "load", function(){
    var rule_type = $(".assigned_rule_type").val();
    rule_type_changed(rule_type);
})

function rule_type_changed(rule_type) {
   $(".assigned_rule").empty();
    if (rule_type){
        $.ajax({
            url: "/get_rules.json",
            contentType: "application/json",
            dataType: "json",
            data: { rule_type: rule_type },
            type: 'get',
            success: function(data){
                var rules_arr = data['rules_arr']
                rules_arr.forEach(function(rule){
                    $(".assigned_rule").append(new Option(rule, rule));
                });
                var selected_rule = $("#cam_rule_rule").data('selectedRule');
                document.getElementById("cam_rule_rule").value = selected_rule;
                
            }
        });
    }
    else{
        $('.assigned_rule').val(0);
    }
}
