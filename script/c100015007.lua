--100005007
function c100005007.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_LVCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c100005007.lvtg)
	e1:SetOperation(c100005007.lvop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e2)	
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetCategory(CATEGORY_CONTROL+CATEGORY_EQUIP)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c100005007.ctcos)
	e3:SetTarget(c100005007.cttar)
	e3:SetOperation(c100005007.ctop)
	c:RegisterEffect(e3)
end
function c100005007.lvfilter(c,lv,code)
	return c:IsFaceup() and c:IsSetCard(0x99) and c:GetLevel()~=0
end
function c100005007.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100005007.lvfilter(chkc,e:GetHandler():GetLevel()) end
	if chk==0 then return Duel.IsExistingTarget(c100005007.lvfilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),e:GetHandler():GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100005007.lvfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),e:GetHandler():GetLevel())
end
function c100005007.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel()+c:GetLevel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c100005007.ctffilter(c,tp)
	return c:IsControlerCanBeChanged() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c100005007.ctfilter,tp,LOCATION_MZONE,0,1,nil,c:GetLevel())
end
function c100005007.ctfilter(c,lv)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() and c:GetLevel()==lv
end
function c100005007.ctcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()	
	if chk==0 then return Duel.IsExistingMatchingCard(c100005007.ctffilter,tp,0,LOCATION_MZONE,1,nil,tp) end
	if tc and tc:IsAbleToRemoveAsCost() then 
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_COST) 
	else 
	return false 
	end
end
function c100005007.cttar(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) 
	and Duel.IsExistingMatchingCard(c100005007.ctfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	if chk==0 then return true end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local sg=Duel.SelectTarget(tp,c100005007.ctffilter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	e:SetLabel(sg:GetFirst():GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,sg,1,0,0)
end
function c100005007.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c100005007.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)==0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end		
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREMOVE)
	local g=Duel.SelectMatchingCard(tp,c100005007.ctfilter,tp,LOCATION_MZONE,0,1,1,nil,e:GetLabel())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)	
	if not g then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end	
	Duel.Equip(tp,c,tc,true)
	--Add Equip limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_CONTROL)
	e2:SetValue(tp)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end