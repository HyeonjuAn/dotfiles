"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[9076],{59076:(e,a,n)=>{n.r(a),n.d(a,{default:()=>b});n(41260);var o=n(96651),t=n(10124),r=n.n(t),l=n(8004),s=n(49232),u=n(12100),c=n(15040),i=n(92292);const d="R4AOm8lBixAuXc0zHhxV",f="ZEgB8UArQwhY4degXB0u",h="vHu13YiEjGcr1tNuM0PU",p="RLqo2hhldWUFTxjcB_R3";var m=n(2488);const b=({colorLight:e,colorDark:a,name:n,years:t})=>{const b=(0,s.IP)(c.We3,{loadingValue:!1}),{enqueueSnackbar:x}=(0,i.u)();(0,o.useEffect)((()=>{if(!b)return;const e=0===t?u._s.get("web-player.album.release",{name:n}):u._s.get("web-player.album.anniversary",t,{name:n,years:`${t}`});x(e)}),[b,n,t,x]);const[y,M]=(0,o.useReducer)(g,{balloons:Array.from({length:25}).map((()=>({animationDuration:Math.floor(50*Math.random())/10+2+"s",transitionDuration:Math.floor(50*Math.random())/10+12+"s",transform:`scale(${Math.floor(.4*Math.random())+.8})`,left:Math.floor(25*Math.random())-25,popped:!1})))}),[k,v]=(0,o.useState)(!1);return(0,o.useEffect)((()=>{const e=setTimeout((()=>{v(!0)}),1e3);return()=>{clearTimeout(e)}}),[v]),b?(0,m.jsx)("div",{className:d,children:y.balloons.map(((n,o)=>{const s=a&&o%2==0?a:e,u=s===a?"textBase":"textSubdued",{popped:c,...i}=n;return(0,m.jsx)("div",{children:(0,m.jsx)("button",{onClick:()=>M(o),className:r()(f,{[h]:k,[p]:c}),style:{"--color":s,...i},children:t>0&&o%3==0&&(0,m.jsx)(l.a,{variant:"headlineLarge",semanticColor:u,children:t})},o)},o)}))}):null};function g(e,a){return{balloons:e.balloons.map(((e,n)=>({...e,popped:a===n||e.popped})))}}}}]);
//# sourceMappingURL=9076.js.map