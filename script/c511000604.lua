--Enemy Controller
function c511000604.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetHintTiming(TIMING_BATTLE_PHASE+TIMING_STANDBY_PHASE,TIMING_BATTLE_PHASE)
e1:SetCost(c511000604.cost)
e1:SetTarget(c511000604.target)
e1:SetOperation(c511000604.activate)
c:RegisterEffect(e1)
end
function c511000604.cost(e,tp,eg,ep,ev,re,r,rp,chk)
e:SetLabel(1)
if chk==0 then return Duel.CheckLPCost(tp,1000)
else Duel.PayLPCost(tp,1000)	end
return true
end
function c511000604.filter(c,e)
return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function c511000604.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
if chk==0 then	
e:SetLabel(0)
return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
end
local g=Duel.GetMatchingGroup(c511000604.filter,tp,0,LOCATION_MZONE,nil,e)
local cg=nil
if e:GetLabel()==1 then cg=g:Filter(Card.IsAbleToChangeControler,nil)
else cg=g:Filter(Card.IsControlerCanBeChanged,nil) end
local sel=0
Duel.Hint(HINT_SELECTMSG,tp,550)
if cg:GetCount()==0 then
sel=Duel.SelectOption(tp,aux.Stringid(90817375,0))
elseif e:GetLabel()==1 and not Duel.CheckReleaseGroup(1-tp,nil,1,nil) then
sel=Duel.SelectOption(tp,aux.Stringid(90817375,0))
else
sel=Duel.SelectOption(tp,aux.Stringid(90817375,0),aux.Stringid(90817375,1))
if sel==1 and e:GetLabel()==1 then
end
end
if sel==0 then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
local sg=g:Select(tp,1,1,nil)
Duel.SetTargetCard(sg)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
else
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
local sg=cg:Select(tp,1,1,nil)
Duel.SetTargetCard(sg)
Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
e:SetLabel(sel)
end
function c511000604.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
if e:GetLabel()==0 then
Duel.Destroy(tc,REASON_EFFECT)
else
if not Duel.GetControl(tc,tp,PHASE_END,1) and not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
Duel.Destroy(tc,REASON_EFFECT)
end
end
end
end