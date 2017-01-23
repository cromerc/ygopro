--ハイパー・コート
function c100000089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100000089.condition)
	e1:SetTarget(c100000089.target)
	e1:SetOperation(c100000089.operation)
	c:RegisterEffect(e1)
end
function c100000089.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
c100000089.collection={
	[33725002]=true;[66970002]=true;[87911394]=true;[511000993]=true;[51865604]=true; --V Salamander, Utopia V.., Z
	[72677437]=true;[8062132]=true; --Venom
	[78371393]=true;[4779091]=true;[31764700]=true; --Yubel
	[62180201]=true;[57793869]=true;[21208154]=true; --Wicked Gods
	[87526784]=true;[23915499]=true;[50319138]=true; --Crashbug
	[511000908]=true;[511000909]=true;[511000910]=true; --Debugger
	[61156777]=true; --BOXer
	[51638941]=true;[96300057]=true;[62651957]=true;[65622692]=true;[64500000]=true; --VWXYZ
	[58859575]=true;[2111707]=true;[99724761]=true;[25119460]=true;[91998119]=true;[84243274]=true; --VWXYZ Fusions
}
function c100000089.setchk(c)
	return (c:IsSetCard(0x5) and c:GetCode()~=35781051 and c:GetCode()~=8396952 and c:GetCode()~=123203 and c:GetCode()~=62892347) --Arcana Force with X and V
		or c:IsSetCard(0x50) or c:IsSetCard(0x32) or c:IsSetCard(0x8e) or c:IsSetCard(0x5008) or c:IsSetCard(0x41) --Venom, Volcanic, Vampire, Vision Hero, LV
		or c:IsSetCard(0x30) or c:IsSetCard(0x3e) or c:IsSetCard(0x58) or c:IsSetCard(0x66) or c:IsSetCard(0x7e) --Vylon, Worm, Wind-Up, Warrior, ZW
		or c:IsSetCard(0xe) or c:IsSetCard(0x100d) or c:IsSetCard(0x73) or c:IsSetCard(0xb3) or c:IsSetCard(0x9e) --Watt, X-Saber, Xyz, Yosenju, Yang Zing
		or c:IsSetCard(0xc4) or c:IsSetCard(0xc1) --Zefra, PSY-Frame
end
function c100000089.filter(c)
	return c:IsFaceup() and (c100000089.setchk(c) or c100000089.collection[c:GetCode()]) and c:IsRace(RACE_MACHINE)
end
function c100000089.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c100000089.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000089.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100000089.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000089.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--Atk/def
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		--Equip limit
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EQUIP_LIMIT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(c100000089.eqlimit)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(c100000089.efilter)
		c:RegisterEffect(e3,true)
	end
end
function c100000089.eqlimit(e,c)
	return (c100000089.setchk(c) or c100000089.collection[c:GetCode()]) and c:IsRace(RACE_MACHINE)
end
function c100000089.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
