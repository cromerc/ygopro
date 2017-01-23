--Number F0: Future Hope
function c511000192.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511000192.xyzcon)
	e1:SetOperation(c511000192.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--rank
	c:SetStatus(STATUS_NO_LEVEL,true)
	--indes
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--damage val
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000192,0))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_DAMAGE_STEP_END)
	e5:SetTarget(c511000192.atktg)
	e5:SetOperation(c511000192.atkop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_BE_BATTLE_TARGET)
	e6:SetTarget(c511000192.atktg2)
	c:RegisterEffect(e6)
	--prevent destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(59251766,0))
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCost(c511000192.cost)
	e7:SetOperation(c511000192.op2)
	c:RegisterEffect(e7)
	--prevent effect damage
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(20450925,0))
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetCountLimit(1)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCost(c511000192.cost)
	e8:SetOperation(c511000192.op3)
	c:RegisterEffect(e8)
	if not c511000192.xyz_filter then
		c511000192.xyz_filter=function(mc) return mc:IsType(TYPE_XYZ) and mc:IsCanBeXyzMaterial(c) end
	end
	if not c511000192.global_check then
		c511000192.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511000192.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511000192.xyz_number=0
c511000192.minxyzct=2
c511000192.maxxyzct=2
c511000192.maintain_overlay=true
function c511000192.ovfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end	
function c511000192.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c511000192.ovfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c511000192.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000192.ovfilter,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g1=Duel.SelectMatchingCard(tp,c511000192.ovfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=Duel.SelectMatchingCard(tp,c511000192.ovfilter,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	og=Group.CreateGroup()
	og:Merge(g1)
	og:Merge(g2)
	if g1:GetCount()>0 then
		local mg1=g1:GetFirst():GetOverlayGroup()
		if mg1:GetCount()~=0 then
			og:Merge(mg1)
			Duel.Overlay(g2:GetFirst(),mg1)
		end
		Duel.Overlay(g2:GetFirst(),g1)
		local mg2=g2:GetFirst():GetOverlayGroup()
		if mg2:GetCount()~=0 then
			og:Merge(mg2)
			Duel.Overlay(c,mg2)
		end
		c:SetMaterial(og)
		Duel.Overlay(c,g2:GetFirst())	
	end
end
function c511000192.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetAttackTarget()~=nil then
		Duel.SetTargetCard(Duel.GetAttackTarget())
	end
end
function c511000192.atktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c511000192.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_BATTLE,1)
	end
end
function c511000192.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000192.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e2)
	end
end
function c511000192.op3(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c511000192.damval)
	e1:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e1,tp)
end
function c511000192.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
function c511000192.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,65305468)
	Duel.CreateToken(1-tp,65305468)
end
