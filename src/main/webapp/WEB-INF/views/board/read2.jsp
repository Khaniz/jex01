<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Read Page</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Dashboard v1</li>
                    </ol>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->


    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- left column -->
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Board Read</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <div class="card-body">
                            <div class="form-group">
                                <label for="exampleInputEmail10">BNO</label>
                                <input type="text" name="bno" class="form-control" id="exampleInputEmail10" placeholder="blank bno" value="<c:out value="${boardDTO.bno}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Title</label>
                                <input type="text" name="title" class="form-control" id="exampleInputEmail1" placeholder="blank title" value="<c:out value="${boardDTO.title}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail2">Writer</label>
                                <input type="text" name="writer" class="form-control" id="exampleInputEmail2" placeholder="blank writer" value="<c:out value="${boardDTO.writer}"></c:out>" readonly>
                            </div>
                            <div class="row">
                                <div class="col-sm-12"> <!-- 6??? ?????? 12??? ?????? -->
                                    <!-- textarea -->
                                    <div class="form-group">
                                        <label>Textarea</label>
                                        <textarea name="content" class="form-control" rows="3" placeholder="Enter ..." disabled><c:out value="${boardDTO.content}"></c:out></textarea> <!-- textarea??? ???????????? -->
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <button type="button" class="btn btn-default btnList" style="float:left">??????</button>
                            <button type="button" class="btn btn-info btnMod" style="float:right">??????/??????</button>
                        </div>

                    </div>
                    <!-- /.card -->

                    <!-- replies -->
                    <div class="card direct-chat direct-chat-primary">
                        <div class="card-header">
                            <h3 class="card-title">Replies</h3>

                            <div class="card-tools">
                                <span title="3 New Messages" class="badge badge-primary addReplyBtn">Add Reply</span>
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-comments"></i>
                                </button>
                                <button type="button" class="btn btn-tool" data-card-widget="remove">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="direct-chat-messages">

                                <!-- /.direct-chat-msg -->

                            </div>
                            <!--/.replies -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


</div>

<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <!-- ???????????? ?????? ???????????? ?????? -->
    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%-- modal start --%>
<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Reply</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" name="replyer">
                <input type="text" name="reply">

            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                <button type="button" class="btn btn-primary operBtn">save change</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal exd-->

<!-- large modal -->
<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modify/Remove</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="rno">
                <input type="text" name="replyerMod">
                <input type="text" name="replyMod">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-info btnModReply">Modify</button>
                <button type="button" class="btn btn-danger btnRem">Remove</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp"%>


<script>

    const actionForm = document.querySelector("#actionForm");

    document.querySelector(".btnList").addEventListener("click" ,() => {
        actionForm.submit();
    }, false) //btnList??? page??? size??? ???????????? ??????

    document.querySelector(".btnMod").addEventListener("click", () => {

        const bno = '${boardDTO.bno}';
        //??????????????? bno??? ?????????

        actionForm.setAttribute("action", "/board/modify")
        actionForm.innerHTML += `<input type='hidden' name='bno' value='\${bno}'>`
        actionForm.submit();
    })

</script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script> <!-- axios??? ???????????? ????????? ?????? -->
<script src="/resources/js/reply.js"> //js ?????? </script>

<script>

    function after(result) {
        console.log("after..........");
        console.log(result)
    }
    /*

        // reply.js??? ??????????????? doA??? doB??? ?????????
        // doA??? ???????????? promise(????????????) ???????????? ????????????.
        // promise??? ?????? doA??? ?????????????????? then??? ???????????? ???.(??? ????????? ????????? ?????????)
        doA().then(result => console.log(result));

        doB(after)

        // axios??? ???????????? json?????? data??? ?????? ??????. java ????????? ???????????? ????????????.
        const reply = {bno:230, replyer:'user00',reply:'22222222'}

        doC(reply).then(result => console.log(result))

        // delete
        doD(112).then(result => console.log(result))

        // put(??????/??????)
        const reply = {rno:112, reply:"Update reply text...."}
        doE(reply).then(result => console.log(result))
    */

    //?????? ??????????????? ?????? ?????? ????????? ????????? ?????? ? ?????? ?????? ??? ?????? ????????? ????????? ????????? ?????? ?????? ??? ????????? ???????????????
    // -> ????????? ??? ?????? ???????????? ??????????????? ????????????

</script>
