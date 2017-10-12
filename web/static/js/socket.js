
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket= (topicId) => {
let channel = socket.channel(`comments:${topicId}`, {});
channel
  .join()
  .receive("ok", resp => { 
    renderComments(resp.comments)
  })

  .receive("error", resp => { 
   
  })

  channel.on(`comments:${topicId}:new`, renderComment); //this is to handle the broadcast
  
  // document.querySelector('button').addEventListener('click', function() {
  //   channel.push('comment:hello', {hi: 'there'});
  // }) used this to test if channel works


  document.querySelector('button').addEventListener('click', () =>{
    const content = document.querySelector('textarea').value;

    channel.push('comment:add', { content: content});
  })
}

function renderComments(comments) { //this is for the first pass
  const renderedComments = comments.map(comment => {
   return commentTemplate(comment);

  });
  document.querySelector('.collection').innerHTML = renderedComments.join('');

}


function renderComment(event){ //this is specifically for turning one comment into an li and then adding it to the existing list
 const renderedComment = commentTemplate(event.comment);

 document.querySelector('.collection').innerHTML += renderedComment;
}




function commentTemplate(comment){
  return `
  <li class="collection-item">
    ${comment.content}
  </li>
`;

}
window.createSocket = createSocket;