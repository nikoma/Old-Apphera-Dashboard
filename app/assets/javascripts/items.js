$(document).ready(function () {

		$(".item-data").click( function () {

			var this_id = $(this).get(0).id;			
			var str = ".item-detail-" + this_id;
//			alert(str);
			$(str).toggle(200);

			//unbold
			$("#span-"+this_id).attr('class', '');


			//mark seen
			$("#edit_item_"+this_id +" #item_new").val('f')
			update_item(this_id)

		
		});

});



$(document).ready(function () {
		$("#share-twitter").click( function () {						
         	window.open($(this).attr("data-twitter-intent"), 'Apphera', 'scrollbars=yes,width=600,height=450');
  //        	retrun false;
		});
});


$(document).ready(function () {
	$(".drag").dragdrop({
		 makeClone: true,
         sourceHide: false,
		 dropClass: "bold",
         didDrop: function($src, $dst) {

         	var item_id = $src.attr("item-id");

            $("#edit_item_" + item_id + " #item_folder").val($dst.attr("id"));

//            alert($("#edit_item_" + item_id + " #item_folder").val());
            update_item(item_id);
        }
	});



	$(".bs-docs-sidenav li")

});



function update_item(id)
{
	$("#edit_item_"+ id).submit();
}