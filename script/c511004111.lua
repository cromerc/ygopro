--Wasteland Tornado
--scripted by:urielkama
function c511004111.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511004111,0))
e1:SetCategory(CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c511004111.target)
e1:SetOperation(c511004111.activate)
c:RegisterEffect(e1)
end
function c511004111.dessptfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511004111.setsptfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c511004111.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_SZONE) and c511004111.dessptfilter(chkc) and chkc~=e:GetHandler() end
if chk==0 then return Duel.IsExistingTarget(c511004111.dessptfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler()) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
local g=Duel.SelectTarget(tp,c511004111.dessptfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511004111.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local dp=tc:GetControler()
		local g=Duel.GetMatchingGroup(c511004111.setsptfilter,dp,LOCATION_HAND,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(dp,aux.Stringid(511004111,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,510)
			local sg=g:Select(dp,1,1,nil)
			Duel.SSet(dp,sg:GetFirst())
		end
	end
end