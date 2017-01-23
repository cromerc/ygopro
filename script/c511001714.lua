--Pendulum Climax
function c511001714.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001714.target)
	e1:SetOperation(c511001714.activate)
	c:RegisterEffect(e1)
end
function c511001714.cfilter(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsType(TYPE_PENDULUM) and Duel.IsExistingMatchingCard(c511001714.eqfilter,tp,0,LOCATION_GRAVE,1,nil,lv)
end
function c511001714.eqfilter(c,lv)
	return c:GetLevel()>0 and lv==c:GetLevel() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001714.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:GetBattledGroupCount()>0 
		and Duel.CheckReleaseGroup(tp,c511001714.cfilter,1,c,tp)
end
function c511001714.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if not e:GetHandler():IsLocation(LOCATION_SZONE) then ft=ft-1 end
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001714.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001714.filter,tp,LOCATION_MZONE,0,1,nil,tp) and ft>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511001714.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tr=Duel.SelectReleaseGroup(tp,c511001714.cfilter,1,1,g:GetFirst(),tp)
	e:SetLabel(tr:GetFirst():GetLevel())
	Duel.Release(tr,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,0,LOCATION_GRAVE)
end
function c511001714.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
		local g=Duel.SelectMatchingCard(tp,c511001714.eqfilter,tp,0,LOCATION_GRAVE,1,1,nil,e:GetLabel())
		local ec=g:GetFirst()
		if ec then
			Duel.HintSelection(g)
			if not Duel.Equip(tp,ec,tc,false) then return end
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511001714.eqlimit)
			ec:RegisterEffect(e1)
			local e2=Effect.CreateEffect(tc)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(ec:GetTextAttack()/2)
			ec:RegisterEffect(e2)
			local e3=Effect.CreateEffect(tc)
			e3:SetType(EFFECT_TYPE_EQUIP)
			e3:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e3:SetCode(EFFECT_EXTRA_ATTACK)
			e3:SetValue(1)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			ec:RegisterEffect(e3)
		end
	end
end
function c511001714.eqlimit(e,c)
	return e:GetOwner()==c
end
